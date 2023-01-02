// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:notespace_home_screen/home_screen.dart';

class HomeApp extends StatelessWidget {
  const HomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
