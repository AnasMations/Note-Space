import 'dart:ffi';
import 'dart:io';

import 'package:file_picker/file_picker.dart';

import 'package:flut_fire_training/providers/user_provider.dart';
import 'package:flut_fire_training/screens/common_widgets/bottom_navigation_bar.dart';
import 'package:flut_fire_training/screens/other_user_profile_screen/other_user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

import 'package:provider/provider.dart';

import '../../models/note_model.dart';
import '../../models/user_model.dart';
import '../../services/firebase-services.dart';
import '../../style/custom_style.dart';

class NoteExpandedViewScreen extends StatelessWidget {
  NoteExpandedViewScreen(this._note, {super.key});
  Note _note;
  @override
  Widget build(BuildContext context) {
    var customWidth = MediaQuery.of(context).size.width * 0.9;
    return Scaffold(
        bottomNavigationBar: CustomBottomNavBar(0),
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: [
            //TODO: add like functionality
            IconButton(
              icon: Icon(
                Icons.outlined_flag,
                color: Colors.black,
              ),
              onPressed: () {
                //TODO:flag note whatever that will mean in the future
              },
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * 0.05,
              MediaQuery.of(context).size.height * 0.01,
              MediaQuery.of(context).size.width * 0.05,
              0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                    //category widget
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width * 0,
                        MediaQuery.of(context).size.height * 0.01,
                        MediaQuery.of(context).size.width * 0.05,
                        MediaQuery.of(context).size.height * 0.01,
                      ),
                      //category title
                      child: Container(
                        decoration: CustomStyle.customBoxDecoration(true, true),
                        child: Text(
                          "  " + _note.category + "  ",
                          style:
                              TextStyle(fontSize: CustomStyle.subAverageSize),
                        ),
                      ),
                    ),
                    //note card and name
                    Material(
                      elevation: 6,
                      shadowColor: Colors.grey.shade300,
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      child: Container(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.013),
                        height: MediaQuery.of(context).size.height * 0.45,
                        width: customWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey.shade200,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                                flex: 20,
                                fit: FlexFit.loose,
                                child: Container(
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image:
                                            NetworkImage(_note.coverImageUrl)),
                                  ),
                                )),
                            Flexible(flex: 1, child: Text('')),
                            Flexible(
                                flex: 2,
                                child: Text("    " + _note.name,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.bold,
                                      fontSize: CustomStyle.averageSize,
                                    ))),
                          ],
                        ),
                      ),
                    ),

                    //download button and note stats
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.01),
                      width: customWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Flexible(
                              flex: 6,
                              fit: FlexFit.tight,
                              child: OutlinedButton(
                                  child: Text('Download'),
                                  onPressed: () async {
                                    // await FlutterDownloader.initialize();
                                    Directory appDocDir =
                                        await getApplicationDocumentsDirectory();
                                    String appDocPath = appDocDir.path;
                                    //TODO:add download functionality
                                    await FlutterDownloader.enqueue(
                                      url: '${_note.fileUrl}',
                                      //headers: {}, // optional: header send with url (auth token etc)
                                      savedDir: appDocPath,

                                      showNotification:
                                          true, // show download progress in status bar (for Android)
                                      openFileFromNotification:
                                          true, // click on notification to open downloaded file (for Android)
                                    );
                                  })),
                          Flexible(
                            flex: 4,
                            child: FittedBox(
                              fit: BoxFit.fill,
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${_note.downloadCount} Downloads',
                                    style: TextStyle(
                                      fontSize: CustomStyle.subAverageSize,
                                    ),
                                  ),
                                  Text(
                                    '${_note.viewCount} Views',
                                    style: TextStyle(
                                        fontSize: CustomStyle.subAverageSize),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        '${_note.rating}  ',
                                        style: TextStyle(
                                            fontSize:
                                                CustomStyle.subAverageSize),
                                      ),
                                      Icon(
                                        Icons.thumb_up_sharp,
                                        color: CustomStyle.colorPalette[2],
                                        size: CustomStyle.averageSize,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //uploader pic , name and uni
                    GestureDetector(
                      onTap: () async {
                        //TODO:link to user profile page
                        User? user = await FirestoreServices.fetchUser(
                            _note.uploaderUID);
                        if (user != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    (OtherUserProfileView(user)),
                              ));
                        } else
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'This users profile is temporarily uniavailable')));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical:
                                MediaQuery.of(context).size.height * 0.01),
                        width: customWidth,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              flex: 6,
                              fit: FlexFit.loose,
                              child: CircleAvatar(
                                radius: CustomStyle.subMassiveTitleSize * 1.2,
                                foregroundImage:
                                    NetworkImage(_note.uploaderPicUrl),
                                foregroundColor: CustomStyle.colorPalette[2],
                              ),
                            ),
                            Flexible(
                              flex: 4,
                              fit: FlexFit.tight,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ' ${_note.uploaderName}',
                                    style: TextStyle(
                                        fontSize:
                                            CustomStyle.subMassiveTitleSize,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    ' ${_note.uploaderUniversity}',
                                    style: TextStyle(
                                        fontSize: CustomStyle.averageSize),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //note description
                    Padding(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.height * 0.01),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height * 0.01,
                            horizontal:
                                MediaQuery.of(context).size.height * 0.01),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        width: customWidth,
                        child: Text(_note.description,
                            style: TextStyle(overflow: TextOverflow.ellipsis),
                            maxLines: 4),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.height * 0.01),
                        child: Text(
                          'Comments',
                          style: TextStyle(
                              fontSize: CustomStyle.averageSize,
                              fontWeight: FontWeight.bold),
                        )),
                  ] +
                  //comments
                  commentWidgetBuilder(_note.comments, context, customWidth),
            ),
          ),
        ));
  }

  List<Widget> commentWidgetBuilder(List<Map<String, dynamic>> comments,
      BuildContext context, double? customWidth) {
    List<Widget> commentWidgets = [];
    for (Map<String, dynamic> comment in comments) {
      commentWidgets.add(GestureDetector(
        onTap: () async {
          //TODO:link to user profile page
          User? user =
              await FirestoreServices.fetchUser(comment['commenterUid']);
          if (user != null) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => (OtherUserProfileView(user)),
                ));
          } else
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content:
                    Text('This users profile is temporarily uniavailable')));
        },
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.01,
                horizontal: MediaQuery.of(context).size.height * 0.01),
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            width: customWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: CustomStyle.subMassiveTitleSize * 0.6,
                      foregroundImage:
                          NetworkImage(comment['commenterCoverImageUrl']),
                      foregroundColor: CustomStyle.colorPalette[2],
                    ),
                    Text(
                      ' ${comment['commenterName']}',
                      style: TextStyle(
                          fontSize: CustomStyle.averageSize,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.01,
                      horizontal: MediaQuery.of(context).size.height * 0.01),
                  child: Text(
                    '${comment['comment']}',
                    style: TextStyle(fontSize: CustomStyle.subAverageSize),
                  ),
                ),
              ],
            ),
          ),
        ),
      ));
    }
    return commentWidgets;
  }
}
