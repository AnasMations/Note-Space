import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flut_fire_training/screens/note_expanded_view_screen/note_expanded_view_screen.dart';
import 'package:flut_fire_training/screens/publish_note_screen/publish_note_screen.dart';
import 'package:flut_fire_training/screens/sign_in/sign_in_screen.dart';
import 'package:flut_fire_training/screens/update_profile_screen/edit_profile_screen.dart';

import 'package:flut_fire_training/style/custom_style.dart';

import 'package:flutter/material.dart';

import 'models/note_model.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseStorage.instance.setMaxDownloadRetryTime(Duration(
        days: 0,
        hours: 0,
        microseconds: 0,
        milliseconds: 0,
        minutes: 0,
        seconds: 10));
    FirebaseStorage.instance.setMaxUploadRetryTime(Duration(
        days: 0,
        hours: 0,
        microseconds: 0,
        milliseconds: 0,
        minutes: 0,
        seconds: 10));
    FirebaseStorage.instance.setMaxOperationRetryTime(Duration(
        days: 0,
        hours: 0,
        microseconds: 0,
        milliseconds: 0,
        minutes: 0,
        seconds: 10));
    return MaterialApp(
        theme: Theme.of(context).copyWith(
          inputDecorationTheme: CustomStyle.customInputDecoration,
          elevatedButtonTheme: CustomStyle.customElevatedButtonTheme,
          textButtonTheme: CustomStyle.customTextButtonTheme,
          outlinedButtonTheme: CustomStyle.customOutlinedButtonTheme,
        ),
        title: 'NoteSpace',
        home: SignInScreenManual());
  }
}
