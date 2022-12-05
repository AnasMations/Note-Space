import 'package:flut_fire_training/screens/update_profile_screen/edit_profile_screen.dart';
import 'package:flut_fire_training/style/custom_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';
import '../common_widgets/bottom_navigation_bar.dart';
import '../common_widgets/user_profile_card.dart';

class MainUserProfileView extends StatelessWidget {
  const MainUserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    //connect this variable to provider
    final mainUser = Provider.of<UserProvider>(context).getMainUser();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              //put edit profile screen
              builder: ((context) => UpdateProfile()),
            ),
          );
        },
        backgroundColor: CustomStyle.colorPalette[1],
        child: const Icon(Icons.edit),
      ),
      bottomNavigationBar: const CustomBottomNavBar(3),
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 6,
            child: Stack(alignment: AlignmentDirectional.center, children: [
              Container(
                padding: EdgeInsets.fromLTRB(
                  0,
                  0,
                  0,
                  MediaQuery.of(context).size.height * (0.6 - 0.32),
                ),
                decoration: BoxDecoration(color: Colors.black),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.32,
                  decoration: CustomStyle.customBoxDecoration(false, true,
                      boxRadius: 60),
                ),
              ),
              UserProfileCard(mainUser: mainUser)
            ]),
          ),
          Flexible(
              flex: 1,
              child: Text(
                'My Notes',
                style: TextStyle(
                    fontSize: CustomStyle.averageSize,
                    fontWeight: FontWeight.bold),
              ))
        ],
      ),
    );
  }
}
