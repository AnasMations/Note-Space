import 'package:flut_fire_training/models/user_model.dart';

import 'package:flut_fire_training/services/firebase-services.dart';
import 'package:flut_fire_training/style/custom_style.dart';

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
      home: Scaffold(
        appBar: AppBar(
          title: Text('Test file picker'),
        ),
        body: Center(
          child: OutlinedButton(
            child: Text('pick a photo'),
            onPressed: () async {
              String url =
                  await StorageServices.uploadUserPhoto(User(uID: '123'));
              print(url);
            },
          ),
        ),
      ),
    );
  }
}
