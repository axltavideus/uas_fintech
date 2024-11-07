import 'package:flutter/material.dart';
import 'bottom_nav_bar.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 3; // Profile page is index 3

  void _onNavBarTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    
    // Logic for navigating to different pages based on the index
    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (index == 1) {
      // Navigate to Pay page
    } else if (index == 2) {
      // Navigate to History page
    } else if (index == 3) {
      // Profile page, no navigation needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Profile Page"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[700]!, Colors.blue[400]!],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        AssetImage('assets/profile_picture.jpg'), // Replace with your profile image
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Randy',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.qr_code, color: Colors.white),
                    label: Text(
                      "QR SAYA",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black54,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  buildProfileField("Nama Lengkap", "Randy Wijaya Deus"),
                  SizedBox(height: 10),
                  buildProfileField("No. Telpon", "+62 877-8249-8390"),
                  SizedBox(height: 10),
                  buildProfileField("Email", "Axel@gmail.com"),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Ubah Security Code"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      side: BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue[800],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.help_outline, color: Colors.white),
                        SizedBox(width: 10),
                        Text(
                          "AXEL Siap membantu dengan kesulitan yang akan datang!!!",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // Replacing the default BottomNavigationBar with BottomNavBar
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: _onNavBarTap, // Adding navigation logic
      ),
    );
  }

  Widget buildProfileField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
        SizedBox(height: 5),
        TextField(
          enabled: false,
          decoration: InputDecoration(
            hintText: value,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
