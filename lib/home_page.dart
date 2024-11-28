import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:uas_fintech/camera_page.dart';
import 'package:uas_fintech/detail_transaction.dart';
import 'package:uas_fintech/history_page.dart';
import 'package:uas_fintech/metode_transfer.dart';
import 'package:uas_fintech/promo_detail_page.dart';
import 'bottom_nav_bar.dart';
import 'sign_up.dart';
import 'login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'topup_page.dart';
import 'otheruser_page.dart';
import 'history_page.dart';
import 'transfer_saldo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'promo_detail_page1.dart';
import 'promo_detail_page2.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  int _currentBalance = 0;
  List<Map<String, dynamic>> _recentTransactions = []; 
  String _name = '';

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
    _loadTopUpAmount();
    _loadTransactionHistory();
    _fetchUsername();
  }

  void _checkLoginStatus() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    // Jika pengguna belum login, arahkan ke halaman login
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }
}

  Future<void> _loadTopUpAmount() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentBalance = prefs.getInt('topUpAmount') ?? 0; // Ensure it’s retrieved as an integer
    });
  }

  Future<void> _updateTopUpAmount() async {
    _loadTopUpAmount(); // Reload balance only if top-up was successful
  }

  void _loadTransactionHistory() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList('transactionHistory') ?? [];
    setState(() {
      _recentTransactions = history.reversed.take(1).map((item) => jsonDecode(item) as Map<String, dynamic>).toList();
    });
  }

  Future<void> _fetchUsername() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (userDoc.exists) {
          setState(() {
            _name = userDoc['name'] ?? 'No username found';
          });
        } else {
          setState(() {
            _name = 'User not found';
          });
        }
      } catch (e) {
        print('Error fetching username: $e');
        setState(() {
          _name = 'Error loading username';
        });
      }
    }
  }

  void _onNavBarTap(int index) {
    setState(() {
      _selectedIndex = index; // Update selectedIndex
    });

    // Navigasi berdasarkan index
    if (index == 0) {
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, '/pay');
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, '/history');
    } else if (index == 3) {
      Navigator.pushReplacementNamed(context, '/profile');
    }
  }

  Future<bool?> _showLogoutDialog() async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Konfirmasi Logout"),
          content: Text("Apakah Anda yakin ingin keluar?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // If canceled
              },
              child: Text("Batal"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // If confirmed

                // Use addPostFrameCallback to navigate after the dialog is dismissed
                WidgetsBinding.instance.addPostFrameCallback((_) async {
                  final user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    await FirebaseAuth.instance.signOut();
                  }
                  Navigator.pushReplacementNamed(context, '/login');
                });
              },
              child: Text("Keluar"),
            ),
          ],
        );
      },
    );
  }

  final List<Map<String, String>> otherPeople = [
    {
      "name": "Alice",
      "imageUrl": "https://via.placeholder.com/50",
    },
    {
      "name": "Bob",
      "imageUrl": "https://via.placeholder.com/50",
    },
    {
      "name": "Charlie",
      "imageUrl": "https://via.placeholder.com/50",
    },
  ];

  final List<String> imgList = [
    'https://bankmega.com/media/filer_public/7c/fd/7cfdf499-4b4f-42a8-abfd-a2f3c4cda8e1/0d-bm-banner-shopee.jpg',
    'https://ichef.bbci.co.uk/news/1024/branded_news/14E77/production/_133532658_ukraine-russia-promo.png',
    'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgTr074wf0VhmJLJHRpGKcxxkeo34RcDV3btrVOMzzRCovMlgr_nXOuoqdmma0eHyqY0toO_i5RLNM2YjrnahYXNw_or7h--tEDsmImYjOYQqmbr4wd7N_LULrVVckyAV5Hxs5ceyb4ocjOJPkevkSDSINZ5nCxg9SwfsmfqkF0U1cikdDO-sWZ1pQONA/s800/smart-power-all-50-sim-registered-promo.png',
  ];

  final List<Widget> promoPages = [
    const PromoDetailPage(),      // First promo page
    const PromoDetailPage1(),     // Second promo page
    const PromoDetailPage2(),           // Third promo page
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Section
              Row(
                children: [
                  const CircleAvatar(
                    backgroundImage:
                        NetworkImage('https://via.placeholder.com/50'),
                  ),
                  SizedBox(width: 8.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Welcome back,",
                          style: TextStyle(fontSize: 16, color: Colors.grey)),
                      Text(_name,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.exit_to_app_rounded),
                    onPressed: () async {
                      final confirmLogout = await _showLogoutDialog();
                      if (confirmLogout ?? false) {
                        final user = FirebaseAuth.instance.currentUser;
                        if (user != null) {
                          await FirebaseAuth.instance.signOut();
                          Navigator.pushReplacementNamed(context, '/login');
                        } else {
                          Navigator.pushReplacementNamed(context, '/login');
                        }
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16.0),

              // Balance Section with dynamic top-up amount
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 35, 43, 156),
                      Color.fromARGB(255, 56, 68, 244),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Saldo Anda,",
                        style: TextStyle(color: Colors.white)),
                    const SizedBox(height: 8.0),
                    Text(
                      "Rp. ${NumberFormat('#,###').format(_currentBalance)}", // Display the dynamic top-up amount
                      style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: IconButton(
                            icon: const Icon(Iconsax.add_circle,
                                color: Color.fromARGB(255, 51, 62, 221)),
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TopUpPage()),
                              );
                              if (result == true) {
                                _loadTopUpAmount(); // Update the displayed balance
                                _loadTransactionHistory();  // Reload transaction history
                              }
                            },
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: IconButton(
                            icon: const Icon(Iconsax.money_send,
                                color: Color.fromARGB(255, 51, 62, 221)),
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MetodePay()),
                              );
                              if (result == true) {
                                _loadTopUpAmount();
                                _loadTransactionHistory(); 
                              }
                            },
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: IconButton(
                            icon: const Icon(Iconsax.scan_barcode,
                                color: Color.fromARGB(255, 51, 62, 221)),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CameraPage()),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16.0),

              // Other People Section
              const Text("Other People",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8.0),
              Row(
                children: otherPeople.map((person) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OtherUserPage(
                            name: person["name"]!,
                            imageUrl: person["imageUrl"]!,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(person["imageUrl"]!),
                          ),
                          const SizedBox(height: 4.0),
                          Text(person["name"]!),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16.0),

              // Recent Transactions Section
              const Text("Recent Transaction", 
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8.0),
              if (_recentTransactions.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    final latestTransaction = _recentTransactions[0];
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailTransaction(
                          recipient: latestTransaction['recipient'],
                          targetAccount: latestTransaction['targetAccount'],
                          transactionType: latestTransaction['transactionType'],
                          sourceAccount: latestTransaction['sourceAccount'],
                          amount: latestTransaction['amount'],
                        ),
                      ),
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.all(10),
                    elevation: 5,
                    child: ListTile(
                      contentPadding: EdgeInsets.all(15),
                      leading: Container(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat('dd MMM').format(DateTime.parse(_recentTransactions[0]['date'])),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                            Text(
                              DateTime.parse(_recentTransactions[0]['date']).year.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      title: Text(_recentTransactions[0]['recipient']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_recentTransactions[0]['transactionType']),
                          SizedBox(height: 5),
                          Text(
                            "Rp. ${NumberFormat('#,###').format(double.parse(_recentTransactions[0]['amount'].replaceAll(RegExp(r'[^0-9.-]'), '')))}",
                            style: TextStyle(
                              color: _recentTransactions[0]['amount'].contains('-') ? Colors.redAccent : Colors.green,
                            ),
                          ),
                        ],
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ),
              if (_recentTransactions.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'No recent transactions.',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              const SizedBox(height: 16.0),

              // Recommendation Section
              const Text("Rekomendasi Pilihan",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8.0),
              CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                ),
                items: imgList.map((imageUrl) {
                  return Builder(
                    builder: (BuildContext context) {
                      return GestureDetector(
                        onTap: () {
                          // Navigate to PromoDetailPage when tapped
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PromoDetailPage()),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: _onNavBarTap,
      ),
    );
  }
}
