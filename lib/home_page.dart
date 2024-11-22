import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:carousel_slider/carousel_slider.dart';
// Removed duplicate import
import 'package:uas_fintech/camera_page.dart';
import 'package:uas_fintech/detail_transaction.dart';
import 'package:uas_fintech/history_page.dart';
import 'package:uas_fintech/promo_detail_page.dart';
import 'bottom_nav_bar.dart';
import 'sign_up.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'topup_page.dart';
import 'history_page.dart';
import 'transfer_saldo.dart';
import 'promo_detail_page1.dart';
import 'promo_detail_page2.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  int _currentBalance = 0;

  @override
  void initState() {
    super.initState();
    _loadTopUpAmount();
  }

  Future<void> _loadTopUpAmount() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentBalance = prefs.getInt('topUpAmount') ??
          0; // Ensure it’s retrieved as an integer
    });
  }

  Future<void> _updateTopUpAmount() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TopUpPage()),
    );
    _loadTopUpAmount(); // Refresh top-up amount after returning
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
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage('https://via.placeholder.com/50'),
                  ),
                  const SizedBox(width: 8.0),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Welcome back,",
                          style: TextStyle(fontSize: 16, color: Colors.grey)),
                      Text("Randy Interview",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.exit_to_app_rounded),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
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
                      "Rp. $_currentBalance", // Display the dynamic top-up amount
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
                            onPressed:
                                _updateTopUpAmount, // Update amount on top-up
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
                                    builder: (context) => const TransferSaldoPage()),
                              );
                              if (result == true) {
                                _loadTopUpAmount();
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
                                    builder: (context) => const CameraPage()),
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
                  return Padding(
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
                  );
                }).toList(),
              ),
              const SizedBox(height: 16.0),

// Recent Transactions Section
              const Text("Recent Transaction",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8.0),
              
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HistoryPage()),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("30 Okt 2024",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("Nasi goreng pakde har"),
                          Text("-IDR 28.000.00",
                              style: TextStyle(color: Colors.red)),
                        ],
                      ),
                      Chip(
                        label: const Text(
                          "Berhasil",
                          style:
                              TextStyle(color: Color.fromARGB(255, 1, 92, 12)),
                        ),
                        backgroundColor:
                            const Color.fromARGB(255, 146, 248, 180),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 4.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios),
                    ],
                  ),
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
                items: imgList.asMap().entries.map((entry) {
                  int index = entry.key; // Index gambar
                  String imageUrl = entry.value; // URL gambar
                  return Builder(
                    builder: (BuildContext context) {
                      return GestureDetector(
                        onTap: () {
                          // Navigasi ke halaman promo berdasarkan index
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => promoPages[index],
                            ),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(imageUrl), // Gunakan URL gambar
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