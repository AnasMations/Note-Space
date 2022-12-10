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
      "https://firebasestorage.googleapis.com/v0/b/notespace-alpha-app2022.appspot.com/o/users%2Fdefault%2F283-2833820_user-icon-orange-png.png?alt=media&token=3c67cc40-738d-473d-9dbb-75daebbf8f56";
  String university = "";
  String userDescription = "About";
  int totalRating = 0;
  int downloadCount = 0;
  int viewCount = 0;

  //+lists containing references to uploaded notes , downloaded notes ,upvoted notes , downvoted notes , commented notes , reported notes
  List<String> likedNotesReferences = [];
  List<String> dislikedNotesReferences = [];
  List<String> commentedNotesReferences = [];
  List<String> uploadedNotesReferences = [];
  List<String> downloadedNotesReferences = [];
  //constructors
  User({
    required this.name,
    required this.uID,
    required this.university,
    required this.coverImageUrl,
    required this.totalRating,
    required this.viewCount,
    required this.downloadCount,
    required this.userDescription,
    required this.commentedNotesReferences,
    required this.uploadedNotesReferences,
    required this.downloadedNotesReferences,
    required this.likedNotesReferences,
    required this.dislikedNotesReferences,
  });

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
      coverImageUrl: data?['coverImageUrl'],
      likedNotesReferences:
          List<String>.from(data?['likedNotesReferences'] as List),
      downloadedNotesReferences:
          List<String>.from(data?['downloadedNotesReferences'] as List),
      dislikedNotesReferences:
          List<String>.from(data?['dislikedNotesReferences'] as List),
      commentedNotesReferences:
          List<String>.from(data?['commentedNotesReferences'] as List),
      uploadedNotesReferences:
          List<String>.from(data?['uploadedNotesReferences'] as List),
    );
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
      'viewCount': viewCount,
      'likedNotesReferences': likedNotesReferences,
      'dislikedNotesReferences': dislikedNotesReferences,
      'downloadedNotesReferences': downloadedNotesReferences,
      'uploadedNotesReferences': uploadedNotesReferences,
      'commentedNotesReferences': commentedNotesReferences,
    };
  }
}
