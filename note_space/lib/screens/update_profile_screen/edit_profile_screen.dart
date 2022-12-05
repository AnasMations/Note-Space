// ignore_for_file: use_build_context_synchronously, dead_code

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flut_fire_training/style/custom_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';

import '../../services/firebase-services.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({
    Key? key,
  }) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final _formKey = GlobalKey<FormState>();
  bool changedPic = false;

  String? tempName;
  String? tempUniversity;
  String? tempDescription;
  FilePickerResult? tempProfilePicResult;
  String? tempCoverImageUrl;

  @override
  Widget build(BuildContext context) {
    //connect this variable to provider
    final mainUser = Provider.of<UserProvider>(context).getMainUser();

    return Scaffold(
      //bottomNavigationBar: const CustomBottomNavBar(2),
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(
            'Edit profile',
            style: TextStyle(),
          ),
          backgroundColor: CustomStyle.colorPalette[2]),
      // appBar: AppBar(title: const Text('Testing fetching users')),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
            0, MediaQuery.of(context).size.height * 0.05, 0, 0),
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.832,
            decoration: CustomStyle.customBoxDecoration(
              true,
              false,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      flex: 4,
                      fit: FlexFit.loose,
                      child: GestureDetector(
                          onTap: () async {
                            tempProfilePicResult =
                                await StorageServices.pickAPhoto();
                            if (tempProfilePicResult != null)
                              setState(() {
                                changedPic = true;
                              });
                          },
                          child: !changedPic
                              ? CircleAvatar(
                                  radius:
                                      MediaQuery.of(context).size.width * 0.24,
                                  foregroundImage:
                                      NetworkImage(mainUser.coverImageUrl),
                                  foregroundColor: CustomStyle.colorPalette[2],
                                )
                              : CircleAvatar(
                                  radius:
                                      MediaQuery.of(context).size.width * 0.24,
                                  foregroundImage: FileImage(File(
                                      tempProfilePicResult!.files.first.path!)),
                                  foregroundColor: CustomStyle.colorPalette[2],
                                )),
                    ),
                    Flexible(
                      child: TextFormField(
                        initialValue: mainUser.name,
                        decoration: const InputDecoration(
                          hintText: 'My Name',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please tell us your name';
                          } else {
                            tempName = value;
                          }
                          return null;
                        },
                      ),
                    ),
                    Flexible(
                      child: TextFormField(
                        initialValue: mainUser.university,
                        decoration: const InputDecoration(
                          hintText: 'My University',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please tell us your university';
                          } else {
                            tempUniversity = value;
                          }
                          return null;
                        },
                      ),
                    ),
                    Flexible(
                      child: TextFormField(
                        initialValue: mainUser.userDescription,
                        validator: (value) {
                          tempDescription = value;

                          return null;
                        },
                        maxLines: 3,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: 'About Myself',
                          //  label: Text('About Myself'),
                        ),
                      ),
                    ),
                    OutlinedButton(
                        onPressed: (() async {
                          print('save pressed');

                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Saving...')));
                            //attempt to upload the new image if user is trying to change it
                            if (tempProfilePicResult != null) {
                              tempCoverImageUrl =
                                  await StorageServices.uploadToStorage(
                                      mainUser.uID, tempProfilePicResult, 0);
                              if (tempCoverImageUrl == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Unsuccesful! please try again!')));
                                print('scaffoled is showing');
                                return;
                              }
                            }
                            //try to change data om database
                            print('attempting change');
                            final bool succeded =
                                await Provider.of<UserProvider>(context,
                                        listen: false)
                                    .modifyMainUserInfo(
                                        name: tempName,
                                        description: tempDescription,
                                        university: tempUniversity,
                                        coverImageUrl: tempCoverImageUrl);
                            if (succeded) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Saved Succesfully!')));
                              print('change succesful');
                              // Navigator.of(context).pop();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Something went wrong....please try again!')));
                              print('change Unsuccesful');
                            }
                          } else
                            print('form invalid');
                        }),
                        child: const Text('Save'))
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
