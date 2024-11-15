import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pin_code.dart';

class ForgotPinPage extends StatefulWidget {
  const ForgotPinPage({super.key});

  @override
  _ForgotPinPageState createState() => _ForgotPinPageState();
}

class _ForgotPinPageState extends State<ForgotPinPage> {
  final _emailOrPhoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _newPinController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isNewPinVisible = false;

  bool _isValidEmail(String email) {
    return email.contains('@');
  }

  bool _isValidPin(String pin) {
    return pin.length == 6 && RegExp(r'^[0-9]+$').hasMatch(pin);
  }

  Future<void> _confirmPin() async {
    // Check if the fields are empty
    if (_emailOrPhoneController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _newPinController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Warning"),
          content: const Text("Please fill in all fields."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
    // Check if email is valid
    else if (!_isValidEmail(_emailOrPhoneController.text)) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Invalid Email"),
          content: const Text("Please enter a valid email address (e.g. example@example.com)."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
    // Check if PIN is valid (only digits and maximum length of 6)
    else if (!_isValidPin(_newPinController.text)) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Invalid PIN"),
          content: const Text("PIN must be a 6-digit number."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
    else {
      // Save the new PIN to shared preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_pin', _newPinController.text);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PinCodeWidget()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Ganti PIN', 
          style: TextStyle(
            color: Colors.black, 
            fontSize: 20, 
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Email / No. Telepon
              const Text(
                'Email / No. Telepon',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: _emailOrPhoneController,
                    decoration: const InputDecoration(
                      hintText: 'Masukkan email atau nomor telepon',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Password
              const Text(
                'Password',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      hintText: 'Masukkan password',
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // PIN Baru
              const Text(
                'PIN Baru',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: _newPinController,
                    obscureText: !_isNewPinVisible,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Masukkan PIN baru (6 digit)',
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isNewPinVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isNewPinVisible = !_isNewPinVisible;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Confirmation Text
              const Text(
                'Klik Confirm untuk melanjutkan',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),

              // Confirm Button
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  gradient: const LinearGradient(
                    colors: [Colors.blue, Colors.blueAccent],
                  ),
                ),
                child: ElevatedButton(
                  onPressed: _confirmPin,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text(
                    'Confirm',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
