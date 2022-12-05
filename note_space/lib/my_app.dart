import 'package:flut_fire_training/screens/note_expanded_view_screen/note_expanded_view_screen.dart';
import 'package:flut_fire_training/screens/publish_note_screen/publish_note_screen.dart';
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
    return MaterialApp(
        theme: Theme.of(context).copyWith(
          inputDecorationTheme: CustomStyle.customInputDecoration,
          elevatedButtonTheme: CustomStyle.customElevatedButtonTheme,
          textButtonTheme: CustomStyle.customTextButtonTheme,
          outlinedButtonTheme: CustomStyle.customOutlinedButtonTheme,
        ),
        title: 'we learning',
        home: NoteExpandedViewScreen(Note(
          //need to set
          name: "awesomeNote",
          category: "category",
          description: "description",
          fileUrl:
              "https://firebasestorage.googleapis.com/v0/b/my-first-firestore-proj.appspot.com/o/notes%2FGcWYcZRjgmtCJ0tAD8V1%2FNoteFile?alt=media&token=3f0d7692-7a19-4c71-830e-07eaf435f964",
          coverImageUrl:
              "https://firebasestorage.googleapis.com/v0/b/my-first-firestore-proj.appspot.com/o/notes%2Fdefault%2FnoteCoverPic.png?alt=media&token=21ad9619-f66c-4a2e-b78a-bf4dea5944f1", //need to generate and assign
          uID: "uID",
          uploaderUID: "VXohmtw1UIATh5sL2eGn",
          uploaderPicUrl:
              "https://firebasestorage.googleapis.com/v0/b/my-first-firestore-proj.appspot.com/o/users%2Fdefault%2F283-2833820_user-icon-orange-png.png?alt=media&token=9713b855-3b44-4e8a-bdcb-3647c7fef10f",
          uploaderName: "ahmed4.0",
          uploaderUniversity: "Nile university",
          comments: [
            {
              'comment': 'This is an awesome note bro',
              'commenterName': 'Shredder',
              'commenterCoverImageUrl':
                  "https://firebasestorage.googleapis.com/v0/b/my-first-firestore-proj.appspot.com/o/users%2Fdefault%2F283-2833820_user-icon-orange-png.png?alt=media&token=9713b855-3b44-4e8a-bdcb-3647c7fef10f",
              'commenterUid': "VXohmtw1UIATh5sL2eGn"
            },
          ],
          //no need to set
          rating: 100,
          downloadCount: 6,
          viewCount: 3,
        )));
  }
}
