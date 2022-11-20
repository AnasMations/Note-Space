// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:firebase_core/firebase_core.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

class FirestoreServices {
  //attributes
  static final _db = FirebaseFirestore.instance;
  static final _usersCollection =
      FirebaseFirestore.instance.collection('users');

//create a user

  static Future createUser(User user) async {
    //this generates a new empty doc in users collection and gives it the user id to set as the document id
    final newUserDoc = _usersCollection.doc(user.uID); //this is a doc reference
    await newUserDoc.set(user.toFirestore());
  }

  static Future<User?> fetchUser(String? uID) async {
    final userDoc =
        await _usersCollection.doc(uID).get(); //this is a doc snapshot
    if (userDoc.exists)
      return User.fromFirestore(userDoc);
    else
      return null;
  }
}
