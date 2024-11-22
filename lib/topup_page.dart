import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:iconsax/iconsax.dart';
import 'dart:convert';

class TopUpPage extends StatelessWidget {
  final TextEditingController _amountController = TextEditingController();

  TopUpPage({super.key});

  Future<void> _addAmount(String amount) async {
    final prefs = await SharedPreferences.getInstance();
    final currentBalance = prefs.getInt('topUpAmount') ??
        0; // Retrieve existing balance as an integer
    final newAmount = int.tryParse(amount) ?? 0; // Parse input as an integer
    final newBalance = currentBalance + newAmount; // Add new amount

    print('Current Balance: $currentBalance');
    print('New Amount: $newAmount');
    print('New Balance: $newBalance');

    await prefs.setInt(
        'topUpAmount', newBalance); // Store updated balance as an integer
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TopUp', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_2, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            const Text(
              'Nominal',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 8.0),
                  const Text('Rp',
                      style: TextStyle(fontSize: 18, color: Colors.black)),
                  const SizedBox(width: 2.0),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: 'Enter amount',
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Icon(Icons.edit, color: Colors.black),
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: const Color(0xFF2B39D8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () async {
                  final amount = _amountController.text;
                  print('Amount entered: $amount'); // Debug print
                  if (amount.isNotEmpty) {
                    await _addAmount(amount);

                    final prefs = await SharedPreferences.getInstance();
                    List<String> history = prefs.getStringList('transactionHistory') ?? [];

                    history.add(jsonEncode({
                      'date': DateTime.now().toString(),
                      'recipient': 'Top Up',
                      'targetAccount': 'Your Balance',
                      'transactionType': 'Top-Up',
                      'sourceAccount': 'Wallet',
                      'amount': '+IDR $amount',
                    }));

                    await prefs.setStringList('transactionHistory', history);
                    Navigator.pop(context); // Return to HomePage
                  }
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 24),
                    Text('Confirm',
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                    Padding(
                      padding: EdgeInsets.only(right: 16.0),
                      child: Icon(Icons.arrow_forward, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
