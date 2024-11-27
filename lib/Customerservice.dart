import 'package:flutter/material.dart';
import 'bottom_nav_bar.dart';

class CustomerServiceScreen extends StatefulWidget {
  const CustomerServiceScreen({super.key});

  @override
  _CustomerServiceScreenState createState() => _CustomerServiceScreenState();
}

class _CustomerServiceScreenState extends State<CustomerServiceScreen> {
  int _selectedIndex = 0;
  final TextEditingController _controller = TextEditingController();
  final List<ChatBubble> _messages = [
    ChatBubble(
        message:
            'Halo, saya Axel, Customer Service dari DOMPT. Selamat datang!',
        isSentByAssistant: true),
    ChatBubble(
        message: 'Ada yang bisa saya bantu hari ini?', isSentByAssistant: true),
  ];

  void _sendMessage() {
    final String userMessage = _controller.text;
    if (userMessage.isEmpty) return;

    setState(() {
      _messages.add(ChatBubble(message: userMessage, isSentByAssistant: false));
      _controller.clear();
    });

    // Simulating a response from the assistant
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _messages.add(ChatBubble(
          message: _generateResponse(userMessage),
          isSentByAssistant: true,
        ));
      });
    });
  }

  String _generateResponse(String userMessage) {
    if (userMessage.toLowerCase().contains('help')) {
      return 'Tentu! Saya di sini untuk membantu. Apakah Anda membutuhkan bantuan dengan akun Anda, transaksi, atau pembayaran?';
    } else if (userMessage.toLowerCase().contains('phone')) {
      return 'Anda dapat menghubungi Customer Service kami di +62 877-8249-8390. Kami siap membantu Anda!';
    } else if (userMessage.toLowerCase().contains('how are you')) {
      return 'Saya baik, terima kasih! Bagaimana dengan Anda? Semoga hari Anda menyenankan!';
    } else if (userMessage.toLowerCase().contains('balance')) {
      return '''
        Untuk mengecek saldo Anda, ikuti langkah berikut:
        1. Buka aplikasi dan login ke akun Anda.
        2. Pilih menu "Dashboard" atau "Saldo".
        3. Anda akan melihat saldo akun Anda di halaman tersebut.
        Jika ada masalah, Anda bisa menghubungi kami untuk bantuan lebih lanjut.
      ''';
    } else if (userMessage.toLowerCase().contains('transaction')) {
      return '''
        Untuk mengecek status transaksi:
        1. Buka aplikasi dan login.
        2. Pilih menu "Riwayat Transaksi" di dashboard.
        3. Di halaman tersebut, Anda akan melihat status transaksi yang telah Anda lakukan.
        Jika statusnya tidak sesuai, silakan hubungi kami segera.
      ''';
    } else if (userMessage.toLowerCase().contains('payment method')) {
      return '''
        Kami mendukung berbagai metode pembayaran, seperti:
        - Transfer bank
        - Kartu kredit
        - Dompet digital
        Pilih metode pembayaran yang Anda inginkan saat checkout dan ikuti petunjuknya.
      ''';
    } else if (userMessage.toLowerCase().contains('security')) {
      return '''
        Keamanan Anda adalah prioritas kami. Berikut langkah-langkah yang kami lakukan:
        - Enkripsi end-to-end untuk melindungi data transaksi Anda.
        - Verifikasi dua langkah (2FA) untuk akses akun yang lebih aman.
        - Jika Anda merasa akun Anda telah terkompromi, segera ubah password Anda.
      ''';
    } else if (userMessage.toLowerCase().contains('refund')) {
      return '''
        Untuk permohonan refund:
        1. Kunjungi halaman "Bantuan" di aplikasi kami.
        2. Pilih opsi "Ajukan Refund".
        3. Isi formulir permohonan refund dengan informasi transaksi Anda.
        Tim kami akan memprosesnya dan memberi tahu Anda hasilnya dalam waktu 1-3 hari kerja.
      ''';
    } else if (userMessage.toLowerCase().contains('loan')) {
      return '''
        Untuk mengajukan pinjaman:
        1. Buka aplikasi dan masuk ke akun Anda.
        2. Pilih menu "Pinjaman" dan isi data yang diminta.
        3. Tim kami akan mengevaluasi pengajuan Anda dan memberikan keputusan dalam waktu 24 jam.
      ''';
    } else if (userMessage.toLowerCase().contains('account')) {
      return '''
        Jika Anda ingin mengubah data akun, ikuti langkah berikut:
        1. Buka aplikasi dan login ke akun Anda.
        2. Pilih menu "Pengaturan".
        3. Di halaman pengaturan, pilih "Edit Profil" dan ubah informasi Anda sesuai kebutuhan.
        Jangan lupa untuk menyimpan perubahan!
      ''';
    } else {
      return 'Maaf, saya tidak mengerti. Bisa dijelaskan lebih lanjut atau pilih salah satu topik di bawah?';
    }
  }

  void _sendSuggestedMessage(String message) {
    setState(() {
      _messages.add(ChatBubble(message: message, isSentByAssistant: false));
    });

    // Simulating a response from the assistant
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _messages.add(ChatBubble(
          message: _generateResponse(message),
          isSentByAssistant: true,
        ));
      });
    });
  }

  void _onNavBarTap(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, '/pay');
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, '/history');
    } else if (index == 3) {
      Navigator.pushReplacementNamed(context, '/profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Customer Service'),
        backgroundColor: Colors.grey[700],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 40, // Lebar kotak
                  height: 40, // Tinggi kotak
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'D', 
                      style: TextStyle(color: Colors.white, fontSize: 20), 
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Axel Siap membantu',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text('Asisten Virtual'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: _messages,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Ketik pesan...',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  ElevatedButton(
                    onPressed: () => _sendSuggestedMessage('help'),
                    child: const Text('Help'),
                  ),
                  ElevatedButton(
                    onPressed: () => _sendSuggestedMessage('phone'),
                    child: const Text('Contact Us'),
                  ),
                  ElevatedButton(
                    onPressed: () => _sendSuggestedMessage('balance'),
                    child: const Text('Check Balance'),
                  ),
                  ElevatedButton(
                    onPressed: () => _sendSuggestedMessage('transaction'),
                    child: const Text('Transaction History'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: _onNavBarTap,
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSentByAssistant;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isSentByAssistant,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Align(
        alignment: isSentByAssistant
            ? Alignment.centerLeft
            : Alignment.centerRight,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          decoration: BoxDecoration(
            color: isSentByAssistant ? Colors.blue : Colors.green,
            borderRadius: BorderRadius.circular(8), // Kotak
          ),
          child: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}