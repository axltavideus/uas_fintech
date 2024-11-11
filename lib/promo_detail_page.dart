import 'package:flutter/material.dart';
import 'package:uas_fintech/home_page.dart';

void main() {
  runApp(MaterialApp(
    home: PromoDetailPage(),
  ));
}

class PromoDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Promo'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => HomePage())
            );
          },
        ),
      ),
      backgroundColor: Colors.grey[200], // Set background color
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Section
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.orangeAccent, // Placeholder for banner color
                  child: Image.network(
                    'https://mureeskin.id/wp-content/uploads/2023/10/image.png', // Replace with banner image URL
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20), // Space between banner and next section

            // Promo Section
            Container(
              width: double.infinity, // Makes the container full width
              padding: EdgeInsets.all(16.0),
              margin: EdgeInsets.symmetric(vertical: 10.0), // Adds vertical space
              decoration: BoxDecoration(
                color: Colors.white, // Box background color
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // Shadow position
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Promo title
                  Text(
                    'Waktunya seru-seruan bareng doi & amba',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  // Promo description
                  Text(
                    'Mau seru-seruan bareng doi atau bestie di timezone? Bayar pake domku terus bawa pulang rewards-ya!',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),

            // Terms and Conditions Section
            Container(
              width: double.infinity, // Makes the container full width
              padding: EdgeInsets.all(16.0),
              margin: EdgeInsets.symmetric(vertical: 10.0), // Adds vertical space
              decoration: BoxDecoration(
                color: Colors.white, // Box background color
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // Shadow position
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Terms and conditions title
                  Text(
                    'Syarat dan Ketentuan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  // Terms list
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('1. Periode promo: 1-35 November 2069'),
                      Text('2. Pengguna yang melakukan transaksi di Timezone sebanyak dua kali (2x)'),
                      Text('3. Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
                      Text('4. Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
                      Text('5. Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
                      Text('6. Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
