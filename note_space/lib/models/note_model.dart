import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  //attributes

  //randomly generated and assigned to note upon creation
  //don't assign a value to it when creating the note , firebase services will assign the value
  String uID = "";

  //you will assign values to these based on user input
  String name = "";
  String description = "";
  String category = "";
  //these two will be returned by firebase storage services as user picks the file and image
  String fileUrl = "";
  String coverImageUrl = "";

  //you will assign initial values to these
  int rating = 0;
  String uploaderUID = "";
  String uploaderName = "";
  String uploaderUniversity = "";
  String uploaderPicUrl = "";
  int downloadCount = 0;
  int viewCount = 0;
  List<Map<String, dynamic>> comments = [{}];
  // [{'commenterUid':'id','commenterName':'name' , 'commenterCoverImageUrl' :'image url' , 'comment':'comment' } , {}....]
  //+map of comments (commenterRefernce : comment itself) , list of tags

  //constructors

  Note(
      {required this.name,
      required this.uID,
      required this.rating,
      required this.fileUrl,
      required this.coverImageUrl,
      required this.description,
      required this.downloadCount,
      required this.viewCount,
      required this.comments,
      required this.uploaderName,
      required this.uploaderPicUrl,
      required this.uploaderUniversity,
      required this.uploaderUID,
      required this.category});

  //read and write from firestore
  factory Note.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return Note(
        name: data?['name'],
        uID: data?['uID'],
        rating: data?['rating'],
        fileUrl: data?['fileUrl'],
        description: data?['description'],
        coverImageUrl: data?['coverImageUrl'],
        viewCount: data?['viewCount'],
        category: data?['category'],
        downloadCount: data?['downloadCount'],
        uploaderUniversity: data?['uploaderUniversity'],
        uploaderName: data?['uploaderName'],
        uploaderPicUrl: data?['uploaderPicUrl'],
        comments: data?['comments'],
        uploaderUID: data?['uploaderReference']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      'uID': uID,
      'name': name,
      'rating': rating,
      'fileUrl': fileUrl,
      'description': description,
      'coverImageUrl': coverImageUrl,
      'viewCount': viewCount,
      'uploaderUID': uploaderUID,
      'downloadCount': downloadCount,
      'category': category,
      'uploaderName': uploaderName,
      'uploaderUniversity': uploaderUniversity,
      'uploaderPicUrl': uploaderPicUrl,
      'comments': comments,
    };
  }
}
