import 'package:flutter/material.dart';
import 'bottom_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart'; 
import 'dart:convert';
import 'detail_transaction.dart';
import 'package:intl/intl.dart';
import 'package:iconsax/iconsax.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int _selectedIndex = 2;
  List<Map<String, dynamic>> _transactionHistory = []; 
  List<Map<String, dynamic>> _filteredHistory = [];
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _loadTransactionHistory();
  }

  void _loadTransactionHistory() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList('transactionHistory') ?? [];
    setState(() {
      _transactionHistory = history.reversed.map((item) => jsonDecode(item) as Map<String, dynamic>).toList();
      _filteredHistory = _transactionHistory;
    });
  }

  void _filterByDate(DateTime selectedDate) {
    setState(() {
      _selectedDate = selectedDate;
      _filteredHistory = _transactionHistory.where((transaction) {
        DateTime transactionDate = DateTime.parse(transaction['date']);
        return transactionDate.year == selectedDate.year &&
            transactionDate.month == selectedDate.month &&
            transactionDate.day == selectedDate.day;
      }).toList();
    });
  }

  void _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      _filterByDate(pickedDate);
    }
  }

  void _onNavBarTap(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, '/pay');
    } else if (index == 2) {
    } else if (index == 3) {
      Navigator.pushReplacementNamed(context, '/profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_2),
          color: Colors.white,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
        ),
        title: const Text(
          'Transaction History',
          style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 255, 255)),
        ),
        backgroundColor: const Color.fromARGB(255, 56, 68, 244),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            color: Colors.white,
            onPressed: _selectDate,
          ),
        ],
      ),
      body: Column(
        children: [
          if (_selectedDate != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Transactions for ${DateFormat('dd MMM yyyy').format(_selectedDate!)}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredHistory.length,
              itemBuilder: (context, index) {
                final transaction = _transactionHistory[index];
                return Column(
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailTransaction(
                              recipient: transaction['recipient'],
                              targetAccount: transaction['targetAccount'],
                              transactionType: transaction['transactionType'],
                              sourceAccount: transaction['sourceAccount'],
                              amount: transaction['amount'],
                            ),
                          ),
                        );
                      },
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat('dd MMM').format(DateTime.parse(transaction['date'])),
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                            Text(
                              DateTime.parse(transaction['date']).year.toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      title: Text(transaction['recipient']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(transaction['transactionType']),
                          const SizedBox(height: 5),
                          Text(
                            transaction['amount'],
                            style: TextStyle(
                              color: transaction['amount'].contains('+') ? Colors.green : Colors.redAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(  
                      indent: 0,
                      thickness: 1,
                      endIndent: 0,
                      height: 1,
                      color: Colors.grey,  
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: _onNavBarTap,
      ),
    );
  }
}
