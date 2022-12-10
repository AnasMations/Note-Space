import 'package:flut_fire_training/main.dart';
import 'package:flut_fire_training/screens/common_widgets/note_mini_view.dart';
import 'package:flut_fire_training/services/firebase-services.dart';
import 'package:flut_fire_training/style/custom_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user_model.dart';

import '../common_widgets/user_profile_card.dart';

class OtherUserProfileView extends StatefulWidget {
  OtherUserProfileView(this.targetUser, {super.key});
  User targetUser;

  @override
  State<OtherUserProfileView> createState() => OtherUserProfileViewState();
}

class OtherUserProfileViewState extends State<OtherUserProfileView> {
  @override
  Widget build(BuildContext context) {
    //connect this variable to provider

    final uploadedNotesList = widget.targetUser.uploadedNotesReferences;
    return Scaffold(
      //  bottomNavigationBar: const CustomBottomNavBar(2),
      resizeToAvoidBottomInset: false,
      body: RefreshIndicator(
        onRefresh: () async {
          final temp = await FirestoreServices.fetchUser(widget.targetUser.uID);
          if (temp != null)
            setState(() {
              widget.targetUser = temp;
            });
        },
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1.7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 9,
                  child:
                      Stack(alignment: AlignmentDirectional.center, children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(
                        0,
                        0,
                        0,
                        MediaQuery.of(context).size.height * (0.6 - 0.46),
                      ),
                      //  decoration: BoxDecoration(color: Colors.black),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.46,
                        decoration: CustomStyle.customBoxDecoration(false, true,
                            boxRadius: 60),
                      ),
                    ),
                    UserProfileCard(mainUser: widget.targetUser)
                  ]),
                ),
                Flexible(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width * 0.05,
                        0,
                        0,
                        MediaQuery.of(context).size.height * 0.01),
                    child: Text(
                      '${widget.targetUser.name}\'s Uploads',
                      style: TextStyle(
                          fontSize: CustomStyle.averageSize,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Flexible(
                  flex: 7,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.05,
                          0,
                          0,
                          MediaQuery.of(context).size.height * 0.03),
                      child: FutureBuilder(
                        future: FirestoreServices.fetchAllNotesInList(
                            uploadedNotesList),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return Center(child: Text('No uploads yet :('));
                            }
                            List<Widget> miniNotes = [];
                            for (var note in snapshot.data!) {
                              miniNotes.add(Padding(
                                padding: EdgeInsets.only(
                                    right: MediaQuery.of(context).size.width *
                                        0.05),
                                child: NoteMiniView(note),
                              ));
                            }
                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: miniNotes,
                              ),
                            );
                          }
                          return Center(
                            child: const CircularProgressIndicator(),
                          );
                        },
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
