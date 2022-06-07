import 'package:cloud_firestore/cloud_firestore.dart';

class Exercise {
  final String exercise_id;
  final String id_cat;
  final String sentence;
  final String translation;
  final String token;

  const Exercise(
      {required this.id_cat,
      required this.exercise_id,
      required this.sentence,
      required this.translation,
      required this.token});

  factory Exercise.fromSnapshot(DocumentSnapshot docSnapshot) {
    return Exercise(
      exercise_id:  docSnapshot.id,
      id_cat: docSnapshot.get('id_cat'),
      sentence: docSnapshot.get('sentence'),
      translation: docSnapshot.get('translation'),
      token: docSnapshot.get('token'),
    );
  }
}
