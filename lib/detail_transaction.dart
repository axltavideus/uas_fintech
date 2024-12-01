import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class DetailTransaction extends StatelessWidget {
  final String recipient;
  final String targetAccount;
  final String transactionType;
  final String sourceAccount;
  final String amount;
  final String transactionDate; 

  const DetailTransaction({
    required this.recipient,
    required this.targetAccount,
    required this.transactionType,
    required this.sourceAccount,
    required this.amount,
    required this.transactionDate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DOMPT'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Iconsax.arrow_left_2),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Icon(
              Icons.check_circle,
              size: 100,
              color: Colors.blue,
            ),
            SizedBox(height: 20),
            Text(
              'Pembayaran Berhasil',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              // Format tanggal transaksi
              '${DateFormat('dd MMM yyyy, HH:mm').format(DateTime.parse(transactionDate))}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Rp. ${NumberFormat('#,###').format(double.parse(amount.replaceAll(RegExp(r'[^0-9.-]'), '')))}",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: amount.contains('-') ? Colors.redAccent : Colors.green,
              ),
            ),
            SizedBox(height: 50),
            buildInfoRow('Pembayaran ke', recipient),
            buildInfoRow('Transfer ke', targetAccount),
            buildInfoRow('Jenis Transaksi', transactionType),
            buildInfoRow('Jumlah Top Up', amount),
          ],
        ),
      ),
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
