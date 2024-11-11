import 'package:flutter/material.dart';
import 'bottom_nav_bar.dart';
import 'home_page.dart'; 
import 'detail_transaction.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int _selectedIndex = 2;

  void _onNavBarTap(int index) {
  setState(() {
    _selectedIndex = index;
  });

  if (index == 0) {
    Navigator.pushReplacementNamed(context, '/home');
  } else if (index == 1) {
    // Navigate to Pay page
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
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
        title: const Text(
          'Transaction History',
          style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 255, 255)),
        ),
        backgroundColor: const Color.fromARGB(255, 56, 68, 244),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                ),
                ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailTransaction(
                        recipient: "Nemesis Fitness",
                        targetAccount: "0811 - 1245 - 4466",
                        transactionType: "Transfer",
                        sourceAccount: "0812 - 8890 - 1800",
                        amount: "-IDR 250.000",
                      ),
                    ),
                  );
                },
                  leading: Container(
                    padding: EdgeInsets.all(8),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '22 Sep',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        Text(
                          '2024',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  title: const Text("Nemesis Fitness"),
                  subtitle: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Transfer Bank"),
                      SizedBox(height: 5),
                      Text(
                        "IDR 250,000",
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    ],
                  ),
                  
                ),
                const Divider(),
                ListTile(
                  onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailTransaction(
                        recipient: "Nasi Goreng Pak de har",
                        targetAccount: "0811 - 1245 - 4466",
                        transactionType: "Pembayaran QRIS",
                        sourceAccount: "0812 - 8890 - 1800",
                        amount: "-IDR 28.000",
                      ),
                    ),
                  );
                },
                  leading: Container(
                    padding: EdgeInsets.all(8),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '21 Sep',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        Text(
                          '2024',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  title: const Text("Nasi Goreng Pak de har"),
                  subtitle: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Pembayaran Qris"),
                      SizedBox(height: 5),
                      Text(
                        "IDR 28,000",
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                ListTile(
                  onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailTransaction(
                        recipient: "Matthew Russel Paul",
                        targetAccount: "0811 - 1245 - 4466",
                        transactionType: "Transfer",
                        sourceAccount: "0812 - 8890 - 1800",
                        amount: "+IDR 50.000",
                      ),
                    ),
                  );
                },
                  leading: Container(
                    padding: EdgeInsets.all(8),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '20 Sep',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        Text(
                          '2024',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  title: const Text("Matthew Russel Paul"),
                  subtitle: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Transfer Bank"),
                      SizedBox(height: 5),
                      Text(
                        "IDR 50,000",
                        style: TextStyle(color: Color.fromARGB(255, 0, 110, 57)),
                      ),
                    ],
                  ),
                ),
              ],
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
