import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'pin_code.dart';
import 'package:intl/intl.dart';

class TransferSaldoPage extends StatefulWidget {
  @override
  _TransferSaldoPageState createState() => _TransferSaldoPageState();
}

class _TransferSaldoPageState extends State<TransferSaldoPage> {
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  int _currentBalance = 0;

  @override
  void initState() {
    super.initState();
    _loadBalance();
  }

  // Load current balance from shared preferences
  Future<void> _loadBalance() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentBalance = prefs.getInt('topUpAmount') ?? 0;
    });
  }

  // Update balance after transfer
  Future<void> _updateBalance(int amount) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentBalance -= amount;
    });
    await prefs.setInt('topUpAmount', _currentBalance);
  }

  // Record the transaction in shared preferences
  Future<void> _recordTransaction(int amount, String destination) async {
    final prefs = await SharedPreferences.getInstance();
    final transactions = prefs.getStringList('transactionHistory') ?? [];

    Map<String, dynamic> transaction = {
      'date': DateTime.now().toString(),
      'recipient': destination,
      'targetAccount': 'Nomor dituju',
      'transactionType': 'Transfer',
      'sourceAccount': 'Wallet',
      'amount': '-IDR $amount',
    };

    transactions.add(jsonEncode(transaction));
    await prefs.setStringList('transactionHistory', transactions);
  }

  void _onConfirm() async {
    final destination = _destinationController.text;
    final amount = int.tryParse(_amountController.text) ?? 0;

    if (amount <= 0) {
      _showMessage("Please enter a valid amount.");
      return;
    }

    if (amount > _currentBalance) {
      _showMessage("Insufficient balance.");
      return;
    }

    // Navigasikan ke halaman PIN untuk validasi transaksi
    final isPinValid = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PinCodeWidget(isForTransaction: true),
      ),
    );

    // Jika PIN valid, lanjutkan transaksi
    if (isPinValid == true) {
      await _updateBalance(amount);
      await _recordTransaction(amount, destination);
      _showMessage("Transfer successful!", isSuccess: true);
      Navigator.pop(context, true);
    } else {
      _showMessage("Transaction cancelled.");
    }
  }

  // Show success or error message
  void _showMessage(String message, {bool isSuccess = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isSuccess ? Colors.green : Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transfer Saldo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Destination input field
            TextField(
              controller: _destinationController,
              decoration: InputDecoration(labelText: "Destination (Rekening/Nomor Telepon)"),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            SizedBox(height: 16.0),

            // Amount input field
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: "Nominal"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 24.0),

            // Confirm button
            ElevatedButton(
              onPressed: _onConfirm,
              child: Text("Confirm Transfer"),
            ),
            SizedBox(height: 16.0),

            // Display current balance
            Text("Available Balance: Rp. ${NumberFormat('#,###').format(_currentBalance)}", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
