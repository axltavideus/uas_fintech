import 'package:flutter/material.dart';

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
            // Banner Promo with Network Image
            Stack(
              children: [
                Image.network(
                  'https://img.lovepik.com/background/20211021/small/lovepik-e-commerce-promotion-background-image_401327963.jpg', // Ganti URL dengan link gambar yang diinginkan
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  left: 16,
                  bottom: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "OMPET ZONA NYAMAN BAYAR",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              blurRadius: 4.0,
                              color: Colors.black,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Cashback s.d. 50,000 Rupiah",
                        style: TextStyle(
                          color: Colors.yellow[200],
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          shadows: const [
                            Shadow(
                              blurRadius: 4.0,
                              color: Colors.black,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Oktober 2024",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          shadows: [
                            Shadow(
                              blurRadius: 4.0,
                              color: Colors.black,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
                    "Siap buat hunting promo November bareng Ompet? Mulai bayar pake Ompet agar semua jadi lebih hemat.",
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
                        "1. Periode promo berlaku setiap : Selasa dan Kamis di bulan November 2024\n"
                        "2. Promo tidak bisa digabung dengan promo lain\n"
                        "3. Promo hanya berlaku di daerah DKI Jakarta\n"
                        "4. Promo cashback terbatas setiap harinya",
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
