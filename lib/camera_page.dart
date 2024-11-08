import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'bottom_nav_bar.dart';

late List<CameraDescription> _cameras;

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? controller; // Changed to nullable
  bool isCameraInitialized = false; // Flag to check if camera is initialized
  int _selectedIndex = 1; // Assuming "Pay" is the second item on the navbar

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    _cameras = await availableCameras();

    controller = CameraController(
      _cameras[0], // Use the first available camera
      ResolutionPreset.max,
    );

    try {
      await controller!.initialize(); // Use the null-aware operator
      setState(() {
        isCameraInitialized = true; // Set the flag to true when initialized
      });
    } catch (e) {
      if (e is CameraException) {
        // Handle camera exceptions here
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here
            break;
          default:
            // Handle other errors here
            break;
        }
      }
    }
  }

  @override
  void dispose() {
    controller?.dispose(); // Use null-aware operator
    super.dispose();
  }

  void _onNavBarTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Handle page navigation if required
  }

  @override
  Widget build(BuildContext context) {
    // Check if the camera is initialized
    if (!isCameraInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_2, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          // Camera preview
          Expanded(
            child: CameraPreview(
                controller!), // Use Expanded to fill available space
          ),

          // Transfer Bank button
          Padding(
            padding: const EdgeInsets.all(16.0), // Add some padding
            child: ElevatedButton(
              onPressed: () {
                // Action for Transfer Bank button
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0)
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.account_balance,
                    color: Color.fromARGB(255, 51, 62, 221),
                    size: 32,
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Transfer Bank',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
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
