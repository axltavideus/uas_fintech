// home_page.dart

import 'package:flutter/material.dart';
import 'bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onNavBarTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Map<String, String>> otherPeople = [
    {
      "name": "Alice",
      "imageUrl":
          "https://via.placeholder.com/50", // Replace with actual image URL
    },
    {
      "name": "Bob",
      "imageUrl":
          "https://via.placeholder.com/50", // Replace with actual image URL
    },
    {
      "name": "Charlie",
      "imageUrl":
          "https://via.placeholder.com/50", // Replace with actual image URL
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
            horizontal: 16.0, vertical: 10.0), // Adjust padding as needed
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Section
              const Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://via.placeholder.com/50'), // Replace with actual image URL
                  ),
                  SizedBox(width: 8.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Welcome back,",
                          style: TextStyle(fontSize: 16, color: Colors.grey)),
                      Text("Randy Interview",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Spacer(),
                  Icon(Icons.qr_code_scanner),
                ],
              ),
              SizedBox(height: 16.0),

              // Balance Section
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Saldo Anda,", style: TextStyle(color: Colors.white)),
                    SizedBox(height: 8.0),
                    Text("Rp. 100.000.000,00",
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          icon: Icon(Icons.add_circle, color: Colors.white),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.send, color: Colors.white),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.qr_code, color: Colors.white),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),

              // Other People Section
              Text("Other People",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8.0),
              Row(
                children: otherPeople.map((person) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              person["imageUrl"]!), // Load the image URL
                        ),
                        SizedBox(height: 4.0),
                        Text(person["name"]!), // Display the person's name
                      ],
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 16.0),

              // Recent Transactions Section
              Text("Recent Transaction",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8.0),
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("30 Okt 2024"),
                        Text("Nasi goreng pakde har"),
                        Text("-IDR 28.000.00",
                            style: TextStyle(color: Colors.red)),
                      ],
                    ),
                    Chip(
                      label: Text("Berhasil"),
                      backgroundColor: Colors.green,
                    ),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
              SizedBox(height: 16.0),

              // Recommendation Section
              Text("Rekomendasi Pilihan",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(3, (index) {
                  return Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey[300],
                  );
                }),
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
