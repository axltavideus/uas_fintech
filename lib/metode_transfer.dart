import 'package:flutter/material.dart';
import 'package:uas_fintech/camera_page.dart';
import 'package:uas_fintech/home_page.dart';
import 'package:iconsax/iconsax.dart';
import 'package:uas_fintech/transfer_saldo.dart';

class MetodePay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Iconsax.arrow_left_2),
          color: Colors.white,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
        title: const Text(
          'Transfer',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 255, 255)),
        ),
        backgroundColor: const Color.fromARGB(255, 56, 68, 244),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Iconsax.wallet_2, color: Colors.blue, size: 36),  
            title: Text(
              "Dompt Account",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 56, 68, 244)),  
            ),
            subtitle: Text(
              "Transfer dana ke sesama rekening DOMPT"
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
            contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),  
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => TransferSaldoPage()),
              );
            },
          ),
          Divider(color: Colors.grey), 
          ListTile(
            leading: Icon(Iconsax.bank, color: Colors.green, size: 36),  
            title: Text(
              "Other Bank",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 56, 68, 244)),  
            ),
            subtitle: Text(
              "Transfer dana ke bank lain"
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
            contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),  
            onTap: () {
                Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => TransferSaldoPage()),
              );
            },
          ),
          Divider(color: Colors.grey), 
          ListTile(
            leading: Icon(Iconsax.card_receive, color: Colors.orange, size: 36),  
            title: Text(
              "Virtual Account",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 56, 68, 244)),  
            ),
            subtitle: Text(
              "Transfer dana ke rekening Virtual Acccount"
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
            contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),  
            onTap: () {
                Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => TransferSaldoPage()),
              );
            },
          ),
          Divider(color: Colors.grey), 
        ],
      ),
    );
  }
}
