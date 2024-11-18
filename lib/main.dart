import 'package:flutter/material.dart';
import 'package:uas_fintech/camera_page.dart';
import 'home_page.dart';
import 'pin_code.dart';
import 'package:permission_handler/permission_handler.dart';
import 'history_page.dart';
import 'profile.dart';
import 'topup_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _checkPermissions();
  runApp(MyApp());
}

// Function to check and request camera permissions
Future<void> _checkPermissions() async {
  var status = await Permission.camera.status;
  if (!status.isGranted) {
    await Permission.camera.request();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Set the initial route to the PinCodeWidget
      initialRoute: '/pin',
      // Define the available routes
      routes: {
        '/pin': (context) => PinCodeWidget(), // Pin code entry page
        '/home': (context) => HomePage(), // Home page after PIN is entered
        '/profile': (context) => ProfilePage(),
        '/history': (context) => HistoryPage(),
        '/topup': (context) => TopUpPage(), // Add this line
        '/pay': (context) => CameraPage(),
      },
    );
  }
}
