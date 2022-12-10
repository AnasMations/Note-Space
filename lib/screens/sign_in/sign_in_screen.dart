import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flut_fire_training/providers/user_provider.dart';
import 'package:flut_fire_training/screens/update_profile_screen/edit_profile_screen.dart'
    as customUpdate;
import 'package:flut_fire_training/screens/user_profile_screen/main_user_profile_screen.dart';
import 'package:flut_fire_training/services/firebase-services.dart';
import 'package:flut_fire_training/style/custom_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user_model.dart';
import '../common_widgets/app_title.dart';

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
            child: AppTitle(),
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
          AuthStateChangeAction<SigningUp>(((context, state) {})),
          //sign in action
          AuthStateChangeAction<SignedIn>(
            //when a user signs up for the first time , he is authenticated in firebase auth , but he still doesn't exist in our cloud firestore database
            //the user only exists in firebase cloudfirestore if he signs up then finishes updating his profile information
            //if user is authenticated but doesn't exist in firestore database then he hasn't finished setting up his profile
            //so we will always push these kinds of users to update profile screen

            ((context, state) async {
              //users have to finish setting up their profile in order to use the app
              User? fetchedUser =
                  await FirestoreServices.fetchUser(state.user!.uid);
              if (fetchedUser == null ||
                  (fetchedUser != null && fetchedUser.name == "")) {
                final tempUser = User(
                    name: "",
                    coverImageUrl:
                        "https://firebasestorage.googleapis.com/v0/b/notespace-alpha-app2022.appspot.com/o/users%2Fdefault%2F283-2833820_user-icon-orange-png.png?alt=media&token=3c67cc40-738d-473d-9dbb-75daebbf8f56",
                    downloadCount: 0,
                    totalRating: 0,
                    uID: state.user!.uid,
                    university: "",
                    userDescription: "",
                    commentedNotesReferences: [],
                    likedNotesReferences: [],
                    dislikedNotesReferences: [],
                    downloadedNotesReferences: [],
                    uploadedNotesReferences: [],
                    viewCount: 0);
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    });
                await FirestoreServices.createUser(tempUser);
                Provider.of<UserProvider>(context, listen: false)
                    .setMainUser(tempUser);

                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    //put update profile screen here
                    builder: ((context) => customUpdate.UpdateProfile()),
                  ),
                );
              } else {
                //else if user is authenticated and he does exist in firestore database, then go to home screen normally
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    });

                Provider.of<UserProvider>(context, listen: false)
                    .setMainUser(fetchedUser);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    //put home page here
                    builder: ((context) => MainUserProfileView()),
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
