import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  //attributes
  String? uID;
  String? name;
  float? rating;
  String? description;
  String? fileUrl;
  String? coverImageUrl;
  Timestamp? uploadDate;
  String? uploaderReference;
  String? category;

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
    SnapshotOptions? options,
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
