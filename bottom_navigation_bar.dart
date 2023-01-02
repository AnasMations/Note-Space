// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50.0),
      child: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 242, 193, 78),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_rounded,
                size: 30,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.upload_file_outlined,
              size: 30,
            ),
            label: 'Upload',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_box,
              size: 30,
            ),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.amber[800],
      ),
    );
  }
}
