import 'dart:ffi';

import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flut_fire_training/models/user_model.dart';
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
      data: CustomStyle.signInUpCustomTheme,
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
                      data: CustomStyle.signInUpCustomTheme,
                      child: const ForgotPasswordScreen())),
                ),
              );
            }),
          ),
          //sign in action
          AuthStateChangeAction<SignedIn>(
            ((context, state) async {
              if (await FirestoreServices.fetchUser(state.user!.uid) != null) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: ((context) => Theme(
                        data: CustomStyle.signInUpCustomTheme,
                        child: const ProfileScreen())),
                  ),
                );
              } else {
                Navigator.of(context).pushReplacement(
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

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Center(
                child: Text(
              'Update profile',
              style: TextStyle(
                  color: CustomStyle.colorPalette[2],
                  fontSize: CustomStyle.massiveTitleSize,
                  fontWeight: FontWeight.bold),
            )),
          ),
          Expanded(
              flex: 8,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40)),
                    color: CustomStyle.colorPalette[2]),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            color: CustomStyle.colorPalette[1],
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Form(
                            key: GlobalKey<FormState>(),
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: TextFormField(
                                      decoration:
                                          InputDecoration(labelText: 'Name'),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return value;
                                      },
                                    ),
                                  )
                                ])),
                      )
                    ],
                  ),
                ),
              ))
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
