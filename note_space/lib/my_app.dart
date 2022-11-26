import 'package:note_space/models/user_model.dart';
import 'package:note_space/screens/sign_in/sign_in_screen.dart';
import 'package:note_space/screens/update_profile/update_profile.dart';
import 'package:note_space/style/custom_style.dart';

import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Theme.of(context).copyWith(
        inputDecorationTheme: CustomStyle.customInputDecoration,
        elevatedButtonTheme: CustomStyle.customElevatedButtonTheme,
        textButtonTheme: CustomStyle.customTextButtonTheme,
        outlinedButtonTheme: CustomStyle.customOutlinedButtonTheme,
      ),
      title: 'we learning',
      home: SignInScreenManual(),
    );
  }
}
