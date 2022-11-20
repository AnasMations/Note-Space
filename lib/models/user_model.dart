import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class User {
  //attributes
  //firebase auth attributes
  String? name;
  String? uID;
  /*email and password accessed through firebaseauth instance per user , 
  so that user can't get each others passwords and emails
*/
//firestore attributes
  String? coverImageUrl;
  String? university;
  String? userDescription;
  int? totalRating;

  //+lists containing references to uploaded notes , downloaded notes ,upvoted notes , downvoted notes , commented notes , reported notes

  //constructors
  User(
      {this.name,
      this.uID,
      this.university,
      this.coverImageUrl,
      this.totalRating,
      this.userDescription});

  //read and write user to and from database
  factory User.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return User(
        name: data?['name'],
        uID: data?['uID'],
        totalRating: data?['totalRating'],
        university: data?['university'],
        userDescription: data?['userDescription'],
        coverImageUrl: data?['coverImageUrl']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (uID != null) 'uID': uID,
      if (name != null) 'name': name,
      if (totalRating != null) 'totalRating': totalRating,
      if (university != null) 'university': university,
      if (userDescription != null) 'userDescription': userDescription,
      if (coverImageUrl != null) 'coverImageUrl': coverImageUrl
    };
  }
}
