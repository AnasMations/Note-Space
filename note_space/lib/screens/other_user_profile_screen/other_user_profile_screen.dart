import 'package:flut_fire_training/style/custom_style.dart';
import 'package:flutter/material.dart';

import '../../models/user_model.dart';

import '../common_widgets/user_profile_card.dart';

class OtherUserProfileView extends StatelessWidget {
  const OtherUserProfileView(this.targetUser, {super.key});
  final User targetUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
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
                //  decoration: BoxDecoration(color: Colors.black),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.32,
                  decoration: CustomStyle.customBoxDecoration(false, true,
                      boxRadius: 60),
                ),
              ),
              UserProfileCard(mainUser: targetUser)
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
