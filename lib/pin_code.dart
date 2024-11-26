import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pin_lupa.dart';

class PinCodeWidget extends StatefulWidget {
  final bool isForTransaction; // Menentukan apakah digunakan untuk transaksi

  const PinCodeWidget({super.key, this.isForTransaction = false});

  @override
  State<PinCodeWidget> createState() => _PinCodeWidgetState();
}

class _PinCodeWidgetState extends State<PinCodeWidget> {
  String enteredPin = '';
  bool isPinVisible = false;
  String correctPin = '123456'; // Default PIN if not found in preferences

  @override
  void initState() {
    super.initState();
    _loadPin();
  }

  Future<void> _loadPin() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      correctPin = prefs.getString('user_pin') ?? '123456';
    });
  }

  Widget numButton(int number) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: TextButton(
        onPressed: () {
          setState(() {
            if (enteredPin.length < 6) {
              enteredPin += number.toString();
            }
            if (enteredPin.length == 6) {
              _validatePin();
            }
          });
        },
        child: Text(
          number.toString(),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _validatePin() {
    if (enteredPin == correctPin) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Incorrect PIN, try again!')),
      );
      setState(() {
        enteredPin = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 35, 43, 156),
              Color.fromARGB(255, 56, 68, 244),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Masukkan Security Code Kamu',
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50),

                /// Pin code area
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    6,
                    (index) {
                      return Container(
                        margin: const EdgeInsets.all(6.0),
                        width: isPinVisible ? 25 : 16,
                        height: isPinVisible ? 25 : 16,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.0),
                          color: index < enteredPin.length
                              ? isPinVisible
                                  ? const Color.fromARGB(255, 21, 120, 202)
                                  : const Color.fromARGB(255, 255, 255, 255)
                              : const Color.fromARGB(255, 0, 0, 0).withOpacity(0.1),
                        ),
                        child: isPinVisible && index < enteredPin.length
                            ? Center(
                                child: Text(
                                  enteredPin[index],
                                  style: const TextStyle(
                                    fontSize: 17,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              )
                            : null,
                      );
                    },
                  ),
                ),

                /// Visibility toggle button
                IconButton(
                  onPressed: () {
                    setState(() {
                      isPinVisible = !isPinVisible;
                    });
                  },
                  icon: Icon(
                    isPinVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: isPinVisible ? 0.0 : 9.0),

                /// Digits buttons
                for (var i = 0; i < 3; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        3,
                        (index) => numButton(1 + 3 * i + index),
                      ).toList(),
                    ),
                  ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TextButton(onPressed: null, child: SizedBox()),
                      numButton(0),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            if (enteredPin.isNotEmpty) {
                              enteredPin =
                                  enteredPin.substring(0, enteredPin.length - 1);
                            }
                          });
                        },
                        child: const Icon(
                          Icons.backspace,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),

                /// Forgot PIN button
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgotPinPage(fromPage: 'pin_lupa.dart',),
                        ),
                      );
                    },
                    child: const Text(
                      'Lupa PIN',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
