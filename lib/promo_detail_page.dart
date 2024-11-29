import 'package:flutter/material.dart';
import 'dart:math';
void main() {
  runApp(const MaterialApp(
    home: PromoDetailPage(),
  ));
}

class PromoDetailPage extends StatefulWidget {
  const PromoDetailPage({super.key});

  @override
  State<PromoDetailPage> createState() => _PromoDetailPageState();
}

class _PromoDetailPageState extends State<PromoDetailPage> {
  String? randomCode;

  // Function to generate a random code
  String generateRandomCode() {
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    return String.fromCharCodes(
      Iterable.generate(6, (_) => characters.codeUnitAt(Random().nextInt(characters.length))),
    );
  }

  // Show promo card
  void showPromoCard() {
    setState(() {
      randomCode = generateRandomCode();
    });
  }

  // Hide promo card
  void hidePromoCard() {
    setState(() {
      randomCode = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Promo'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Banner Section
                Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.orangeAccent,
                  child: Image.network(
                    'https://mureeskin.id/wp-content/uploads/2023/10/image.png',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),

                // Promo Section
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Waktunya seru-seruan bareng doi & teman',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Mau seru-seruan bareng doi atau bestie di timezone? Bayar pake domku terus dapatkan bonus 10%!',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),

                // Terms and Conditions Section
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Syarat dan Ketentuan',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('1. Periode promo: 1-35 November 2069'),
                          Text('2. Pengguna yang melakukan transaksi di Timezone sebanyak dua kali (2x)'),
                          Text('3. Promo ini tidak dapat digunakan dengan promo lain.'),
                          Text('4. Promo hanya berlaku di daerah DKI Jakarta.'),
                          Text('5. Isi kartu timezone dengan promo membutuhkan minimum Rp 100.000 untuk menggunakan promo.'),
                          Text('6. Syarat dan ketentuan promo dapat berubah sewaktu-waktu tanpa pemberitahuan terlebih dahulu.'),
                        ],
                      ),
                    ],
                  ),
                ),

                // Promo Button
                Center(
                  child: ElevatedButton(
                    onPressed: showPromoCard,
                    child: const Text('Pakai Promo'),
                  ),
                ),
              ],
            ),
          ),

          // Promo Card Overlay
          if (randomCode != null)
            Center(
              child: Card(
                elevation: 8,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Kode Aktif!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[800],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        randomCode!,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: hidePromoCard,
                        child: const Text('Tutup'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}