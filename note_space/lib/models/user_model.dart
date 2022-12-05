import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  //attributes
  //firebase auth attributes
  String name;
  String uID;
  /*email and password accessed through firebaseauth instance per user , 
  so that user can't get each others passwords and emails
*/
//firestore attributes
  String coverImageUrl =
      "https://firebasestorage.googleapis.com/v0/b/my-first-firestore-proj.appspot.com/o/users%2Fdefault%2F283-2833820_user-icon-orange-png.png?alt=media&token=9713b855-3b44-4e8a-bdcb-3647c7fef10f";

  String university = "";
  String userDescription = "About";
  int totalRating = 0;
  int downloadCount = 0;
  int viewCount = 0;

  //+lists containing references to uploaded notes , downloaded notes ,upvoted notes , downvoted notes , commented notes , reported notes

  //constructors
  User(
      {required this.name,
      required this.uID,
      required this.university,
      required this.coverImageUrl,
      required this.totalRating,
      required this.viewCount,
      required this.downloadCount,
      required this.userDescription});

  //read and write user to and from database
  factory User.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return User(
        name: data?['name'],
        uID: data?['uID'],
        totalRating: data?['totalRating'],
        downloadCount: data?['downloadCount'],
        university: data?['university'],
        viewCount: data?['viewCount'],
        userDescription: data?['userDescription'],
        coverImageUrl: data?['coverImageUrl']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      'uID': uID,
      'name': name,
      'totalRating': totalRating,
      'university': university,
      'userDescription': userDescription,
      'coverImageUrl': coverImageUrl,
      'downloadCount': downloadCount,
      'viewCount': viewCount
    };
  }
}
