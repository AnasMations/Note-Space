import 'package:flut_fire_training/screens/sign_in/Sign_in_screen.dart';

import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'we learning', home: SignInScreenManual() //SignInScreenManual(),
        );
  }
}
