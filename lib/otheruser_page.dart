import 'package:flutter/material.dart';
import 'transfer_saldo.dart';

class OtherUserPage extends StatelessWidget {
  final String name;
  final String imageUrl;

  const OtherUserPage({Key? key, required this.name, required this.imageUrl})
      : super(key: key);

  Widget customButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: 150,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 51, 62, 221),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Other User'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Profile Picture
            CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage(imageUrl), // Use NetworkImage for online URLs
            ),
            const SizedBox(height: 20),

            // User Name
            Text(
              name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),

            // Buttons with equal size
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                customButton('Request', () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("QR Code Saya"),
                        content: Image.network(
                          "https://1.bp.blogspot.com/-dHN4KiD3dsU/XRxU5JRV7DI/AAAAAAAAAz4/u1ynpCMIuKwZMA642dHEoXFVKuHQbJvwgCEwYBhgL/s1600/qr-code.png",
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                      : null,
                                ),
                              );
                            }
                          },
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Tutup"),
                          ),
                        ],
                      );
                    },
                  );
                }),
                const SizedBox(width: 20),
                customButton('Pay', () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => TransferSaldoPage()),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
