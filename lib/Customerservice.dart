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
      message: 'Halo, saya Axel, Customer Service dari DOMPT. Selamat datang!',
      isSentByAssistant: true,
    ),
    ChatBubble(
      message: 'Ada yang bisa saya bantu hari ini?', 
      isSentByAssistant: true,
    ),
  ];

  void _sendMessage() {
    final String userMessage = _controller.text.trim();
    if (userMessage.isEmpty) return;

    // Add user message
    setState(() {
      _messages.add(ChatBubble(
        message: userMessage, 
        isSentByAssistant: false
      ));
      _controller.clear();
    });

    // Add assistant response
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _messages.add(ChatBubble(
          message: _generateResponse(userMessage),
          isSentByAssistant: true,
        ));
      });
    });
  }

  String _generateResponse(String userMessage) {
    userMessage = userMessage.toLowerCase();
    
    Map<String, String> responses = {
      'help': 'Tentu! Saya di sini untuk membantu. Apakah Anda membutuhkan bantuan dengan akun Anda, transaksi, atau pembayaran?',
      'phone': 'Anda dapat menghubungi Customer Service kami di +62 877-8249-8390. Kami siap membantu Anda!',
      'how are you': 'Saya baik, terima kasih! Bagaimana dengan Anda? Semoga hari Anda menyenankan!',
      'balance': '''
        Untuk mengecek saldo Anda, ikuti langkah berikut:
        1. Buka aplikasi dan login ke akun Anda.
        2. Pilih menu "Dashboard" atau "Saldo".
        3. Anda akan melihat saldo akun Anda di halaman tersebut.
      ''',
      'transaction': '''
        Untuk mengecek status transaksi:
        1. Buka aplikasi dan login.
        2. Pilih menu "Riwayat Transaksi" di dashboard.
        3. Di halaman tersebut, Anda akan melihat status transaksi.
      ''',
      'payment method': '''
        Kami mendukung berbagai metode pembayaran:
        - Transfer bank
        - Dompet digital
        - Qr payment
      ''',
    };

    // Check for exact or partial matches
    for (var entry in responses.entries) {
      if (userMessage.contains(entry.key)) {
        return entry.value;
      }
    }

    return 'Maaf, saya tidak mengerti. Bisa jelaskan lebih lanjut?';
  }

  void _sendSuggestedMessage(String message) {
    setState(() {
      _messages.add(ChatBubble(
        message: message, 
        isSentByAssistant: false
      ));
    });

    Future.delayed(const Duration(milliseconds: 500), () {
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

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/pay');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/history');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/profile');
        break;
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
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Agent Info Header
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
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
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
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
          ),

          // Chat Messages
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _messages[_messages.length - 1 - index];
              },
            ),
          ),

          // Message Input
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
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),

          // Quick Action Buttons
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 3,
              children: [
                ElevatedButton(
                  onPressed: () => _sendSuggestedMessage('Help'),
                  child: const Text('Help'),
                ),
                ElevatedButton(
                  onPressed: () => _sendSuggestedMessage('Contact Phone'),
                  child: const Text('Contact Us'),
                ),
                ElevatedButton(
                  onPressed: () => _sendSuggestedMessage('Check Balance'),
                  child: const Text('Check Balance'),
                ),
                ElevatedButton(
                  onPressed: () => _sendSuggestedMessage('Transaction History'),
                  child: const Text('Transaction History'),
                ),
              ],
            ),
          ),
        ],
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
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
      child: Align(
        alignment: isSentByAssistant 
            ? Alignment.centerLeft 
            : Alignment.centerRight,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: isSentByAssistant ? Colors.blue : Colors.green,
            borderRadius: BorderRadius.circular(12),
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