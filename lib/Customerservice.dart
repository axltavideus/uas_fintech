import 'package:flutter/material.dart';
import 'bottom_nav_bar.dart'; // Assuming BottomNavBar is already defined

class CustomerServiceScreen extends StatefulWidget {
  const CustomerServiceScreen({super.key});

  @override
  _CustomerServiceScreenState createState() => _CustomerServiceScreenState();
}

class _CustomerServiceScreenState extends State<CustomerServiceScreen> {
  int _selectedIndex = 0;

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
            const Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: 30,
                  child: Text(
                    'D', // Placeholder for logo or icon
                    style: TextStyle(color: Colors.white, fontSize: 24),
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
                children: [
                  ChatBubble(
                    message: 'Halo saya Axel Customer service dari DOMPT',
                    isSentByAssistant: true,
                  ),
                  ChatBubble(
                    message: 'Dengan menindak lanjuti ini, mengartikan bahwa anda dalam kesusahan segera hubungi Customer Service kami di +62 877-8249-8390',
                    isSentByAssistant: true,
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

  const ChatBubble({super.key, required this.message, required this.isSentByAssistant});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSentByAssistant ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          message,
          style: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}
