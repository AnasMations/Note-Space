// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:flut_fire_training/providers/user_provider.dart';
import 'package:flut_fire_training/screens/other_user_profile_screen/other_user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lecle_downloads_path_provider/constants/downloads_directory_type.dart';
import 'package:lecle_downloads_path_provider/lecle_downloads_path_provider.dart';

import 'package:provider/provider.dart';

import '../../models/note_model.dart';
import '../../models/user_model.dart';
import '../../services/firebase-services.dart';
import '../../style/custom_style.dart';

class NoteExpandedViewScreen extends StatefulWidget {
  const NoteExpandedViewScreen(this._note, {super.key});
  final Note _note;

  @override
  State<NoteExpandedViewScreen> createState() => _NoteExpandedViewScreenState();
}

class _NoteExpandedViewScreenState extends State<NoteExpandedViewScreen> {
  @override
  Widget build(BuildContext context) {
    final mainUser = Provider.of<UserProvider>(context).getMainUser();
    bool isInlikes = mainUser.likedNotesReferences.contains(widget._note.uID);
    bool isInDislikes =
        mainUser.dislikedNotesReferences.contains(widget._note.uID);
    bool isInComments =
        mainUser.commentedNotesReferences.contains(widget._note.uID);
    var customWidth = MediaQuery.of(context).size.width * 0.9;
    return Scaffold(
        //   bottomNavigationBar: const CustomBottomNavBar(0),
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: (!mainUser.uploadedNotesReferences
                  .contains(widget._note.uID))
              ? <Widget>[
                  //TODO: add like functionality
                  IconButton(
                    icon: Icon(
                      Icons.thumb_up_alt_rounded,
                      color: isInlikes
                          ? CustomStyle.colorPalette[2]
                          : Colors.black,
                    ),
                    onPressed: () {
                      if (isInlikes) {
                        mainUser.likedNotesReferences.remove(widget._note.uID);
                        Provider.of<UserProvider>(context, listen: false)
                            .modifyMainUserInfo();
                        FirestoreServices.interactWithNote(
                            widget._note, widget._note.uploaderUID,
                            ratingModification: -1);
                      } else {
                        mainUser.likedNotesReferences.add(widget._note.uID);
                        if (isInDislikes) {
                          mainUser.dislikedNotesReferences
                              .remove(widget._note.uID);
                          Provider.of<UserProvider>(context, listen: false)
                              .modifyMainUserInfo();
                          FirestoreServices.interactWithNote(
                              widget._note, widget._note.uploaderUID,
                              ratingModification: 2);
                          return;
                        }
                        FirestoreServices.interactWithNote(
                            widget._note, widget._note.uploaderUID,
                            ratingModification: 1);

                        Provider.of<UserProvider>(context, listen: false)
                            .modifyMainUserInfo();
                      }
                      setState(() {});
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.thumb_down_alt_rounded,
                      color: isInDislikes
                          ? CustomStyle.colorPalette[2]
                          : Colors.black,
                    ),
                    onPressed: () {
                      if (isInDislikes) {
                        mainUser.dislikedNotesReferences
                            .remove(widget._note.uID);
                        Provider.of<UserProvider>(context, listen: false)
                            .modifyMainUserInfo();
                        FirestoreServices.interactWithNote(
                            widget._note, widget._note.uploaderUID,
                            ratingModification: 1);
                      } else {
                        mainUser.dislikedNotesReferences.add(widget._note.uID);
                        if (isInlikes) {
                          mainUser.likedNotesReferences
                              .remove(widget._note.uID);
                          Provider.of<UserProvider>(context, listen: false)
                              .modifyMainUserInfo();
                          FirestoreServices.interactWithNote(
                              widget._note, widget._note.uploaderUID,
                              ratingModification: -2);
                          return;
                        }
                        FirestoreServices.interactWithNote(
                            widget._note, widget._note.uploaderUID,
                            ratingModification: -1);
                        Provider.of<UserProvider>(context, listen: false)
                            .modifyMainUserInfo();
                      }
                      setState(() {});
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.outlined_flag,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      //TODO:flag note whatever that will mean in the future
                    },
                  ),
                ]
              : <Widget>[],
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
              children: <Widget>[
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
                          "  ${widget._note.category}  ",
                          style:
                              TextStyle(fontSize: CustomStyle.subAverageSize),
                        ),
                      ),
                    ),
                    //note card and name
                    Material(
                      elevation: 6,
                      shadowColor: Colors.grey.shade300,
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
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
                                        image: NetworkImage(
                                            widget._note.coverImageUrl)),
                                  ),
                                )),
                            const Flexible(flex: 1, child: Text('')),
                            Flexible(
                                flex: 2,
                                child: Text("    ${widget._note.name}",
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
                              child: const Text('Download'),
                              onPressed: () async {
                                if (!await InternetConnectionChecker()
                                    .hasConnection) {
                                  ScaffoldMessenger.of(context)
                                      .removeCurrentSnackBar();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'No internet connection...')));
                                  return;
                                }
                                if (mainUser.downloadedNotesReferences
                                    .contains(widget._note.uID)) {
                                  ScaffoldMessenger.of(context)
                                      .removeCurrentSnackBar();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Cannot download your own note!')));
                                  return;
                                }

                                DownloadTask? downloadTask;
                                try {
                                  Directory? appDocDir =
                                      await DownloadsPath.downloadsDirectory(
                                          dirType:
                                              DownloadDirectoryTypes.downloads);

                                  final fileRefOnFirebase = FirebaseStorage
                                      .instance
                                      .refFromURL(widget._note.fileUrl);

                                  final meta =
                                      await fileRefOnFirebase.getMetadata();

                                  final extension =
                                      meta.contentType!.split('/')[1];

                                  final file = File(
                                      '${appDocDir!.absolute.path}/${widget._note.name}.$extension');

                                  downloadTask =
                                      fileRefOnFirebase.writeToFile(file);
                                  ScaffoldMessenger.of(context)
                                      .removeCurrentSnackBar();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          action: SnackBarAction(
                                              label: 'cancel',
                                              onPressed: (() {
                                                if (downloadTask!
                                                        .snapshot.state !=
                                                    TaskState.success) {
                                                  downloadTask.cancel();
                                                  ScaffoldMessenger.of(context)
                                                      .removeCurrentSnackBar();
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                          const SnackBar(
                                                              content: Text(
                                                                  'cancelled')));
                                                  return;
                                                }
                                              })),
                                          content: Text(
                                              'download started  ${(meta.size! / 1000000).toStringAsPrecision(3)} mbs')));
                                  downloadTask.snapshotEvents
                                      .listen((taskSnapshot) {
                                    switch (taskSnapshot.state) {
                                      case TaskState.running:
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    '${taskSnapshot.bytesTransferred / meta.size!} % completed')));

                                        break;
                                      case TaskState.paused:
                                        // TODO: Handle this case.
                                        break;
                                      case TaskState.success:

                                        // TODO: Handle this case.

                                        ScaffoldMessenger.of(context)
                                            .clearSnackBars();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content:
                                                    Text('download complete')));
                                        if (!mainUser.downloadedNotesReferences
                                            .contains(widget._note.uID)) {
                                          Provider.of<UserProvider>(context,
                                                  listen: false)
                                              .getMainUser()
                                              .downloadedNotesReferences
                                              .add(widget._note.uID);
                                          Provider.of<UserProvider>(context,
                                                  listen: false)
                                              .modifyMainUserInfo();

                                          FirestoreServices.interactWithNote(
                                              widget._note,
                                              widget._note.uploaderUID,
                                              downloadModification: 1);
                                          setState(() {});
                                        }

                                        break;
                                      case TaskState.canceled:
                                        ScaffoldMessenger.of(context)
                                            .removeCurrentSnackBar();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'download cancelled')));
                                        break;
                                      case TaskState.error:
                                        break;
                                    }
                                  });

                                  //TODO:add download functionality

                                } on Exception catch (e) {
                                  print('cancelled');
                                  if (downloadTask != null) {
                                    downloadTask.cancel();
                                  }
                                  ScaffoldMessenger.of(context)
                                      .removeCurrentSnackBar();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'something went wrong...please try again shortly')));
                                  return;
                                }
                              },
                            ),
                          ),
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
                                    '${widget._note.downloadCount} Downloads',
                                    style: TextStyle(
                                      fontSize: CustomStyle.subAverageSize,
                                    ),
                                  ),
                                  Text(
                                    '${widget._note.viewCount} Views',
                                    style: TextStyle(
                                        fontSize: CustomStyle.subAverageSize),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        '${widget._note.rating}  ',
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
                    buildUploaderWidget(context, customWidth),
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
                                const BorderRadius.all(Radius.circular(10))),
                        width: customWidth,
                        child: Text(widget._note.description,
                            style: const TextStyle(
                                overflow: TextOverflow.ellipsis),
                            maxLines: 4),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.height * 0.01),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Comments',
                              style: TextStyle(
                                  fontSize: CustomStyle.averageSize,
                                  fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                                onPressed: (() {
                                  if (mainUser.uploadedNotesReferences
                                      .contains(widget._note.uID)) return;
                                  String tempText = "";
                                  showDialog(
                                      context: context,
                                      builder: ((context) => AlertDialog(
                                          backgroundColor:
                                              CustomStyle.colorPalette[2],
                                          title: Text('Comment'),
                                          content: TextFormField(
                                            autofocus: true,
                                            initialValue: tempText,
                                            onChanged: (value) =>
                                                tempText = value,
                                          ),
                                          actions: isInComments
                                              ? <Widget>[
                                                  TextButton(
                                                      onPressed: (() {
                                                        if (tempText != "") {
                                                          mainUser
                                                              .commentedNotesReferences
                                                              .add(widget
                                                                  ._note.uID);
                                                          Provider.of<UserProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .modifyMainUserInfo();
                                                          FirestoreServices
                                                              .interactWithNote(
                                                                  widget._note,
                                                                  widget._note
                                                                      .uploaderUID,
                                                                  comment: {
                                                                "commenterUid":
                                                                    "${mainUser.uID}",
                                                                "comment":
                                                                    "$tempText"
                                                              });
                                                          setState(() {});
                                                          Navigator.of(context)
                                                              .pop();
                                                        }
                                                      }),
                                                      child: Text('Submit')),
                                                  TextButton(
                                                      onPressed: (() {
                                                        Navigator.of(context)
                                                            .pop();
                                                      }),
                                                      child: Text('Cancel')),
                                                ]
                                              : <Widget>[
                                                  TextButton(
                                                      onPressed: (() {
                                                        if (tempText != "") {
                                                          mainUser
                                                              .commentedNotesReferences
                                                              .add(widget
                                                                  ._note.uID);
                                                          Provider.of<UserProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .modifyMainUserInfo();
                                                          FirestoreServices
                                                              .interactWithNote(
                                                                  widget._note,
                                                                  widget._note
                                                                      .uploaderUID,
                                                                  comment: {
                                                                "commenterUid":
                                                                    "${mainUser.uID}",
                                                                "comment":
                                                                    "$tempText"
                                                              });
                                                          setState(() {});
                                                          Navigator.of(context)
                                                              .pop();
                                                        }
                                                      }),
                                                      child: Text('Modify')),
                                                  TextButton(
                                                      onPressed: (() {
                                                        Navigator.of(context)
                                                            .pop();
                                                      }),
                                                      child: Text('Cancel')),
                                                  TextButton(
                                                      onPressed: (() {
                                                        mainUser
                                                            .commentedNotesReferences
                                                            .remove(widget
                                                                ._note.uID);
                                                        Provider.of<UserProvider>(
                                                                context,
                                                                listen: false)
                                                            .modifyMainUserInfo();
                                                        FirestoreServices
                                                            .interactWithNote(
                                                          widget._note,
                                                          widget._note
                                                              .uploaderUID,
                                                          removeExistingComment:
                                                              true,
                                                          commenterIDToRemoveFrom:
                                                              mainUser.uID,
                                                        );
                                                        setState(() {});
                                                      }),
                                                      child: Text(
                                                          'Delete comment')),
                                                ])));
                                }),
                                icon: Icon(
                                  Icons.comment,
                                  color: CustomStyle.colorPalette[2],
                                ))
                          ],
                        )),
                  ] +
                  //comments
                  commentWidgetBuilder(
                      widget._note.comments, context, customWidth),
            ),
          ),
        ));
  }

  List<Widget> commentWidgetBuilder(
      List<dynamic> comments, BuildContext context, double? customWidth) {
    List<Widget> commentWidgets = [];
    if (comments.isEmpty) return [];
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
          } else {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content:
                    Text('This users profile is temporarily uniavailable')));
          }
        },
        child: FutureBuilder(
            future: FirestoreServices.fetchUser(comment['commenterUid']),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.01,
                        horizontal: MediaQuery.of(context).size.height * 0.01),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
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
                                  NetworkImage(snapshot.data!.coverImageUrl),
                              foregroundColor: CustomStyle.colorPalette[2],
                            ),
                            Text(
                              ' ${snapshot.data!.name}',
                              style: TextStyle(
                                  fontSize: CustomStyle.averageSize,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * 0.01,
                              horizontal:
                                  MediaQuery.of(context).size.height * 0.01),
                          child: Text(
                            '${comment['comment']}',
                            style:
                                TextStyle(fontSize: CustomStyle.subAverageSize),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            }),
      ));
    }
    return commentWidgets;
  }

  Widget buildUploaderWidget(BuildContext context, double customWidth) {
    return FutureBuilder(
        future: FirestoreServices.fetchUser(widget._note.uploaderUID),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return GestureDetector(
              onTap: () async {
                //TODO:link to user profile page
                if (snapshot.hasData) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            (OtherUserProfileView(snapshot.data!)),
                      ));
                } else {
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                          'This users profile is temporarily uniavailable')));
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.01),
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
                            NetworkImage(snapshot.data!.coverImageUrl),
                        foregroundColor: CustomStyle.colorPalette[2],
                      ),
                    ),
                    Flexible(
                      flex: 4,
                      fit: FlexFit.tight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ' ${snapshot.data!.name}',
                            style: TextStyle(
                                fontSize: CustomStyle.averageSize,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            ' ${snapshot.data!.university}',
                            style:
                                TextStyle(fontSize: CustomStyle.subAverageSize),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
