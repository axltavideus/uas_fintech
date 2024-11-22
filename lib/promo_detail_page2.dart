import 'package:flutter/material.dart';
import 'home_page.dart';
class PromoDetailPage2 extends StatelessWidget {
  const PromoDetailPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Promo"),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              // Fitur Favorit
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Promo disimpan ke favorit!')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Fitur Bagikan
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Promo siap dibagikan!')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Promo
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Colors.purple[700],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "OMPET ZONA NYAMAN BAYAR",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Cashback s.d. 50,000 Rupiah",
                    style: TextStyle(
                      color: Colors.yellow[200],
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Oktober 2024",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            // Promo List
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Sikat Cashback s.d. 100rb di November!",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Siap buat hunting promo November bareng Ompet? Mulai dari bayar tagihan, beli pulsa, paket data, token PLN, hingga top up e-Money semua jadi lebih hemat.",
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      // Navigasi ke halaman lain jika diperlukan
                    },
                    child: const Text(
                      "Lihat Semua",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Syarat dan Ketentuan
                  const ExpansionTile(
                    title: Text(
                      "Syarat dan Ketentuan",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    children: [
                      Text(
                        "1. Periode promo Pulsa dan Paket Data: Selasa - Kamis di bulan November 2024\n"
                        "2. Periode promo Token PLN: Jumat - Minggu di bulan November 2024\n"
                        "3. Periode promo Tagihan: 3-12, 19-30 November 2024\n"
                        "4. Periode promo Angsuran kredit: 4-6, 24-30 November 2024",
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            // Aksi "Beli Sekarang"
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Promo digunakan!')),
            );
          },
          child: const Text(
            "Beli Sekarang",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
