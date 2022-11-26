import 'dart:ffi';

import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flut_fire_training/models/user_model.dart';
import 'package:flut_fire_training/screens/update_profile/update_profile.dart';
import 'package:flut_fire_training/services/firebase-services.dart';
import 'package:flut_fire_training/style/custom_style.dart';

import 'package:flutter/material.dart';

class SignInScreenManual extends StatelessWidget {
  const SignInScreenManual({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //stops keyboard from forcing widgets to resize upwards
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          //upper white area of log in screen and title
          Expanded(
            flex: 3,
            child: SignInScreenTitle(),
          ),

          //orange area with log in form
          Expanded(
            flex: 7,
            child: CustomSignInScreen(),
          ),
        ],
      ),
    );
  }
}

class CustomSignInScreen extends StatelessWidget {
  const CustomSignInScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context)
          .copyWith(scaffoldBackgroundColor: CustomStyle.colorPalette[2]),
      child: SignInScreen(
        providers: [EmailAuthProvider()],
        showAuthActionSwitch: true,
        actions: [
          //forgot password pop up
          ForgotPasswordAction(
            ((context, email) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: ((context) => Theme(
                      data: Theme.of(context).copyWith(
                          scaffoldBackgroundColor: CustomStyle.colorPalette[2]),
                      child: const ForgotPasswordScreen())),
                ),
              );
            }),
          ),
          //sign in action
          AuthStateChangeAction<SignedIn>(
            //if user is authenticated but doesn't exist in firestore database then he hasn't finished setting up his profile
            ((context, state) async {
              if (await FirestoreServices.fetchUser(state.user!.uid) != null) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: ((context) => const ProfileScreen()),
                  ),
                );
              } else {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: ((context) => UpdateProfile()),
                  ),
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}

class SignInScreenTitle extends StatelessWidget {
  const SignInScreenTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Note Space',
            style: TextStyle(
                color: CustomStyle.colorPalette[2],
                fontSize: CustomStyle.massiveTitleSize,
                fontWeight: FontWeight.bold),
          ),
          Text(
            'All the notes you need',
            style: TextStyle(
              color: CustomStyle.colorPalette[5],
              fontSize: CustomStyle.averageSize,
            ),
          )
        ],
      ),
    );
  }
}
