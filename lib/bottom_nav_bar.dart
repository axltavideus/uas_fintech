// bottom_nav_bar.dart

import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  BottomNavBar({required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: selectedIndex == 0 ? Colors.blue : Colors.grey,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.payment,
            color: selectedIndex == 1 ? Colors.blue : Colors.grey,
          ),
          label: 'Pay',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.history,
            color: selectedIndex == 2 ? Colors.blue : Colors.grey,
          ),
          label: 'History',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            color: selectedIndex == 3 ? Colors.blue : Colors.grey,
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}
