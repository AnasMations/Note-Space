// ignore_for_file: prefer_const_constructors

import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flut_fire_training/screens/leaderboard_screen/leaderboard_screen.dart';
import 'package:flut_fire_training/screens/publish_note_screen/publish_note_screen.dart';
import 'package:flut_fire_training/style/custom_style.dart';
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar(this.selectedIndex, {super.key});
  final selectedIndex;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      child: BottomNavigationBar(
        currentIndex: selectedIndex,
        backgroundColor: CustomStyle.colorPalette[2],
        selectedItemColor: CustomStyle.colorPalette[1],
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_rounded,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.upload_file_outlined,
            ),
            label: 'Upload',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.leaderboard_rounded,
            ),
            label: 'Leaderboard',
          ),
        ],
        onTap: (index) {
          switch (index) {
            //TODO: home screen
            case 0:
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: ((context) => Scaffold())));
              break;
            case 1:
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => PublishNoteScreen())));
              break;
            case 2:
              Navigator.of(context).push(
                  MaterialPageRoute(builder: ((context) => ProfileScreen())));
              break;
            case 3:
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: ((context) => LeaderboardScreen())));
              break;
            default:
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: ((context) => ProfileScreen())));
          }
        },
      ),
    );
  }
}
