import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'profile.dart';


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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Set the initial route to the home page
      initialRoute: '/home',
      // Define the available routes
      routes: {
        '/home': (context) => HomePage(),
        '/profile': (context) => ProfilePage(),
      },
    );
  }
}