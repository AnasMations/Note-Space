import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  //attributes

  //randomly generated and assigned to note upon creation
  //don't assign a value to it when creating the note , firebase services will assign the value
  String? uID;

  //you will assign values to these based on user input
  String? name;
  String? description;
  String? category;
  //these two will be returned by firebase storage services as user picks the file and image
  String? fileUrl;
  String? coverImageUrl;

  //you will assign initial values to these
  int? rating;
  Timestamp? uploadDate;
  String? uploaderReference;

  //+map of comments (commenterRefernce : comment itself) , list of tags

  //constructors

  Note(
      {this.name,
      this.uID,
      this.rating,
      this.fileUrl,
      this.coverImageUrl,
      this.description,
      this.uploadDate,
      this.uploaderReference,
      this.category});

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
        uploadDate: data?['uploadDate'],
        category: data?['category'],
        uploaderReference: data?['uploaderReference']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (uID != null) 'uID': uID,
      if (name != null) 'name': name,
      if (rating != null) 'rating': rating,
      if (fileUrl != null) 'fileUrl': fileUrl,
      if (description != null) 'description': description,
      if (coverImageUrl != null) 'coverImageUrl': coverImageUrl,
      if (uploadDate != null) 'uploadDate': uploadDate,
      if (uploaderReference != null) 'uploaderReference': uploaderReference,
      if (category != null) 'category': category,
    };
  }
}
