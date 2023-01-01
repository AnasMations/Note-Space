import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flut_fire_training/services/firebase-services.dart';
import 'package:flut_fire_training/style/custom_style.dart';
import 'package:flutter/material.dart';

// i worked on this part
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
          //action of signing in
          AuthStateChangeAction<SignedIn>(
            //authentication
            //when a user signs up for the first time , he is authenticated in firebase auth , but he still doesn't exist in our cloud firestore database
            //the user only exists in firebase cloudfirestore if he signs up then finishes updating his profile information
            //if user is authenticated but doesn't exist in  database then he hasn't finished setting up his profile
            //so we will always push these kinds of users to update profile screen
            ((context, state) async {
              if (await FirestoreServices.fetchUser(state.user!.uid) == null) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    //put update profile screen here
                    builder: ((context) => Scaffold()),
                  ),
                );
              } else {
                //else if user is authenticated and he does exist in  database, then go to home screen normally
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: ((context) => Scaffold()),
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

//widgets
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
          ), //TEXXT FIELDS
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
