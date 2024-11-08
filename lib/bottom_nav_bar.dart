import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const BottomNavBar({super.key, required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onTap,
      backgroundColor: const Color.fromARGB(255, 56, 68, 244),
      selectedItemColor: Colors.white, 
      unselectedItemColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            selectedIndex == 0 ? Icons.home : Icons.home_outlined,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            selectedIndex == 1 ? Iconsax.money_35 : Iconsax.money_3,
          ),
          label: 'Pay',
        ),
        BottomNavigationBarItem(
          icon: SizedBox(
            width: 24, // Set a fixed width
            height: 24, // Set a fixed height
            child: Icon(
              selectedIndex == 2 ? Iconsax.receipt_15 : Iconsax.receipt,
              size: 24, // Ensure consistent size
            ),
          ),
          label: 'History',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            selectedIndex == 3 ? Icons.person : Icons.person_outline,
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}
