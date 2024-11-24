import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  // Controllers for text fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // Method to show warning dialog
  void _showWarningDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Warning'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Handle the Sign Up process
  void _handleSignUp(BuildContext context) async {
    // Validate inputs
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      _showWarningDialog(context, 'Please fill in all fields');
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      _showWarningDialog(context, 'Passwords do not match');
      return;
    }

    try {
      // Register the user using Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      User? user = userCredential.user;

      if (user != null) {
        // Store user data to Firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'name': nameController.text,
          'phone': phoneController.text,
          'email': emailController.text,
          'createdAt': FieldValue.serverTimestamp(),
        }).then((_) {
          print("User data successfully stored in Firestore");
        }).catchError((e) {
          print("Error while saving user data: $e");
          _showWarningDialog(context, 'Failed to save user data');
        });

        // Optionally, store user name in SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userName', nameController.text);

        // Redirect to Login Page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } else {
        _showWarningDialog(context, 'Sign Up failed. Please try again.');
      }
    } on FirebaseAuthException catch (e) {
      // Handle Firebase authentication error
      _showWarningDialog(context, e.message ?? 'Sign Up failed. Please try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Back Button
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back,
                      color: Color.fromARGB(255, 61, 131, 211)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(height: 10),

              // Lock Icon
              const Icon(
                Icons.lock,
                size: 100,
                color: Colors.grey,
              ),
              const SizedBox(height: 40),

              // Nama Lengkap Card
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: 
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Nama Lengkap',
                      labelStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // No. Telepon Card
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: 
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: 'No. Telepon',
                      labelStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Email Address Card
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: 
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Email Address',
                      labelStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Password Card
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: 
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Confirm Password Card
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: 
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: TextField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Confirm Password',
                      labelStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Sign Up Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 64, 137, 221),
                  padding: 
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  _handleSignUp(context); // Call sign-up handler
                },
                child: const Text(
                  'Sign Up',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              const SizedBox(height: 16),

              // Login Prompt
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Sudah punya akun? ",
                    style: TextStyle(color: Colors.grey),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
