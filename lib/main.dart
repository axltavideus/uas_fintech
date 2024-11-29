import 'package:flutter/material.dart';
import 'package:uas_fintech/camera_page.dart';
import 'home_page.dart';
import 'pin_code.dart';
import 'package:permission_handler/permission_handler.dart';
import 'history_page.dart';
import 'profile.dart';
import 'topup_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login.dart';
import 'landing_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _checkPermissions();
  await Firebase.initializeApp();
  
  // Cek status login pengguna
  User? user = FirebaseAuth.instance.currentUser;
  bool isLoggedIn = user != null; // Determine if user is logged in
  
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

// Function to check and request camera permissions
Future<void> _checkPermissions() async {
  var status = await Permission.camera.status;
  if (!status.isGranted) {
    await Permission.camera.request();
  }
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  // Constructor now accepts isLoggedIn
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Set the initial route based on login status
      initialRoute: isLoggedIn ? '/pin' : '/landing', // If logged in, go to pin, else go to landing page
      // Define the available routes
      routes: {
        '/pin': (context) => PinCodeWidget(), // Pin code entry page
        '/home': (context) => HomePage(), // Home page after PIN is entered
        '/profile': (context) => ProfilePage(),
        '/history': (context) => HistoryPage(),
        '/topup': (context) => TopUpPage(),
        '/pay': (context) => CameraPage(),
        '/login': (context) => LoginPage(),
        '/landing': (context) => LandingPage(), // Landing page for non-logged-in users
      },
    );
  }
}
