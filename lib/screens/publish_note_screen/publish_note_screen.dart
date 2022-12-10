import 'dart:io';

import 'package:file_picker/file_picker.dart';

import 'package:flut_fire_training/providers/user_provider.dart';
import 'package:flut_fire_training/screens/user_profile_screen/main_user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:provider/provider.dart';

import '../../models/note_model.dart';
import '../../services/firebase-services.dart';
import '../../style/custom_style.dart';

class PublishNoteScreen extends StatefulWidget {
  const PublishNoteScreen({super.key});

  @override
  State<PublishNoteScreen> createState() => _PublishNoteScreenState();
}

class _PublishNoteScreenState extends State<PublishNoteScreen> {
  final _formKey = GlobalKey<FormState>();
  bool changedPic = false;
  bool addedFile = false;

  FilePickerResult? tempNotePicResult;
  FilePickerResult? tempNoteFileResult;
  Note tempNote = Note(
    //need to set
    name: "",
    category: "",
    description: "",
    fileUrl: "",
    coverImageUrl:
        "https://firebasestorage.googleapis.com/v0/b/notespace-alpha-app2022.appspot.com/o/notes%2Fdefault%2FSample_Note.png?alt=media&token=f97c72c7-2024-4215-b7b6-e15380850a1c",
    uID: "",
    uploaderUID: "",

    comments: [],
    //no need to set
    rating: 0,
    downloadCount: 0,
    viewCount: 0,
  );
  @override
  Widget build(BuildContext context) {
    final mainUser = Provider.of<UserProvider>(context).getMainUser();
    return Scaffold(
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
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 2,
            child: Text(
              'Publish Note',
              style: TextStyle(
                  color: CustomStyle.colorPalette[2],
                  fontSize: CustomStyle.massiveTitleSize,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Flexible(
            flex: 8,
            fit: FlexFit.tight,
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height * 1,
                decoration: CustomStyle.customBoxDecoration(
                  true,
                  false,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                            flex: 2,
                            fit: FlexFit.loose,
                            child: OutlinedButton(
                              clipBehavior: Clip.antiAlias,
                              child: !changedPic
                                  ? Text('Choose cover pic')
                                  : Image.file(
                                      File(
                                          tempNotePicResult!.files.first.path!),
                                      fit: BoxFit.scaleDown),
                              onPressed: () async {
                                if (changedPic == false) {
                                  tempNotePicResult =
                                      await StorageServices.pickAPhoto();
                                  if (tempNotePicResult != null)
                                    setState(() {
                                      changedPic = true;
                                    });
                                } else {
                                  tempNotePicResult =
                                      await StorageServices.pickAPhoto();
                                  if (tempNotePicResult == null)
                                    setState(() {
                                      changedPic = false;
                                    });
                                }
                              },
                            )),
                        Flexible(
                          flex: 2,
                          fit: FlexFit.loose,
                          child: OutlinedButton(
                            child: !addedFile
                                ? Text('Choose file')
                                : Icon(
                                    Icons.note_rounded,
                                  ),
                            onPressed: () async {
                              tempNoteFileResult =
                                  await StorageServices.pickANoteFile();
                              if (!addedFile) {
                                if (tempNoteFileResult != null)
                                  setState(() {
                                    addedFile = true;
                                  });
                              } else {
                                if (tempNoteFileResult == null)
                                  setState(() {
                                    addedFile = false;
                                  });
                              }
                            },
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Note Title',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please give your note an awesome Title!';
                              } else {
                                tempNote.name = value;
                              }
                              return null;
                            },
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: FutureBuilder(
                              future: FirestoreServices.fetchCategories(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  if (snapshot.data != null) {
                                    return DropdownButtonFormField(
                                      items: snapshot.data!
                                          .map((item) =>
                                              DropdownMenuItem<String>(
                                                  value: item,
                                                  child: Text(item)))
                                          .toList(),
                                      decoration: const InputDecoration(
                                        hintText: 'Note Category',
                                      ),
                                      onChanged: ((value) =>
                                          tempNote.category = value!),
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Please give your note an appropriate category';
                                        }
                                        return null;
                                      },
                                    );
                                  } else {
                                    return DropdownButtonFormField(
                                      items: ['other']
                                          .map((item) =>
                                              DropdownMenuItem<String>(
                                                  value: item,
                                                  child: Text(item)))
                                          .toList(),
                                      decoration: const InputDecoration(
                                        hintText: 'Note Category',
                                      ),
                                      onChanged: ((value) =>
                                          tempNote.category = value!),
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Please give your note an appropriate category';
                                        }
                                        return null;
                                      },
                                    );
                                  }
                                } else
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                              }),
                        ),
                        Flexible(
                          flex: 2,
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please give your note an awesome description';
                              } else {
                                tempNote.description = value;
                              }
                              return null;
                            },
                            minLines: 2,
                            maxLines: 3,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              hintText: 'Note Description',
                              //  label: Text('About Myself'),
                            ),
                          ),
                        ),
                        OutlinedButton(
                            onPressed: (() async {
                              if (_formKey.currentState!.validate()) {
                                if (!addedFile || tempNoteFileResult == null) {
                                  ScaffoldMessenger.of(context)
                                      .removeCurrentSnackBar();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Please choose the note file!')));
                                  return;
                                }
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

                                //generate a new uid for our note
                                tempNote.uID =
                                    FirestoreServices.generateNoteUID();

                                //attempt to upload cover pic if it exists
                                if (tempNotePicResult != null) {
                                  final tempCoverImageUrl =
                                      await StorageServices.uploadToStorage(
                                          context,
                                          tempNote.uID,
                                          tempNotePicResult,
                                          1);
                                  if (tempCoverImageUrl == null) {
                                    ScaffoldMessenger.of(context)
                                        .removeCurrentSnackBar();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Unsuccesful! please try again!')));

                                    return;
                                  } else
                                    tempNote.coverImageUrl = tempCoverImageUrl;
                                }
                                //attempt to upload file
                                String? tempFileUrl;

                                tempFileUrl =
                                    await StorageServices.uploadToStorage(
                                        context,
                                        tempNote.uID,
                                        tempNoteFileResult,
                                        2);

                                if (tempFileUrl == null) {
                                  ScaffoldMessenger.of(context)
                                      .removeCurrentSnackBar();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Unsuccesful! please try again!')));

                                  return;
                                } else {
                                  tempNote.fileUrl = tempFileUrl;
                                }
                                //assign uploader uid
                                tempNote.uploaderUID = mainUser.uID;

                                await FirestoreServices.createNote(tempNote);
                                mainUser.uploadedNotesReferences
                                    .add(tempNote.uID);
                                //modify uploaded notes at database as well
                                Provider.of<UserProvider>(context,
                                        listen: false)
                                    .modifyMainUserInfo();

                                ScaffoldMessenger.of(context)
                                    .removeCurrentSnackBar();
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Upload Succesful!')));
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            MainUserProfileView())));
                              }
                            }),
                            child: const Text('Upload'))
                      ]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
