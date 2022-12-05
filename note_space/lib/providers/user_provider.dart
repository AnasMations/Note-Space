import 'package:firebase_storage/firebase_storage.dart';
import 'package:flut_fire_training/models/note_model.dart';
import 'package:flut_fire_training/services/firebase-services.dart';
import 'package:flutter/cupertino.dart';

import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  //*********************************attributes************************ */

  UserProvider(User user) {
    this._mainUser = user;
  }

  //main user who actually singed in /up to use our app
  late User _mainUser;

  //a list that will temp contain fetched users from database for simplicities sake
  List<User> _tempFetchedUsers = [];

  //a variable that will temp hold a user we are focusing
  User? _tempFocusedUser = null;

  //getters

  List<User> getTempFetchedUsers() {
    return _tempFetchedUsers;
  }

  //********************Methods on Main user */

  //will be used to set the main user of the app after they succesfully log in / sign up and complete their profile
  void setMainUser(User user) {
    _mainUser = user;
    notifyListeners();
  }

  User getMainUser() {
    return this._mainUser;
  }

  //a user can only modify these 4 variables for now , you need to collect them and verify them ,afterwards call this function and pass the things that changed
  Future<bool> modifyMainUserInfo(
      {String? name,
      String? description,
      String? coverImageUrl,
      String? university}) async {
    User preChange = _mainUser;
    if (name != null) {
      _mainUser.name = name;
    }
    if (description != null) _mainUser.userDescription = description;
    if (coverImageUrl != null) _mainUser.coverImageUrl = coverImageUrl;
    if (university != null) _mainUser.name = university;
    await FirestoreServices.updateUser(_mainUser);
    //add future check for operation success
    /* TaskState task = await FirestoreServices.updateUser(_mainUser);
    if (task != TaskState.success) {
      _mainUser = preChange;
      return false;
    } */
    notifyListeners();
    return true;
  }

  //methods on temp fetched users list
  Future<void> fetchSomeUsersForLeaderBoard(int numberToFetch) async {
    if (_tempFetchedUsers.isEmpty) {
      _tempFetchedUsers =
          await FirestoreServices.fetchAllUsersByrating(numberToFetch);
      notifyListeners();
    } else {
      _tempFetchedUsers.addAll(await FirestoreServices.fetchAllUsersByrating(
          numberToFetch,
          lastUser: _tempFetchedUsers[_tempFetchedUsers.length - 1]));
      notifyListeners();
    }
  }

  //create a new user

  //****************methods on focused user */
  //set focused user
  //dispose focused user
  //upvote focused user
  //downvote focused user

}
