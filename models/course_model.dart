
//import 'package:cloud_firestore/cloud_firestore.dart';

class Course {
  final String course_id;
  final String author;
  final String course_name;
  final String language_from;
  final String language_to;
  final String type;

  const Course( {required this.course_id,required this.author, required this.type, required this.course_name, required this.language_from, required this.language_to});

  /*factory Course.fromJson(Map<String, dynamic> json){
    return Course(
      course_id: json['id'],
      author: json['author'],
        course_name: json['name'],
      language_from: json['language_from'],
      language_to: json['language_to'],
      type: json['type'],
    );
  }

  factory Course.fromSnapshot(DocumentSnapshot docSnapshot) {
    return Course(
      course_id: docSnapshot.id,
      author:  docSnapshot.get('author'),
      course_name: docSnapshot.get('name'),
      language_from: docSnapshot.get('language_from'),
      language_to: docSnapshot.get('language_to'),
      type: docSnapshot.get('type'),
    );
  }*/
}

