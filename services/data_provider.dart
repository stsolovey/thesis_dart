import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thesis/models/course_model.dart';
import 'package:thesis/models/category_model.dart';
import 'package:thesis/models/exercise_model.dart';

class DataProvider {
  Future<List<Course>> getCourse() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('courses').get();
    return snapshot.docs
        .map((doc) => Course(
            course_id: doc.id,
            author: doc.data()['author'],
            course_name: doc.data()['name'],
            language_to: doc.data()['language_to'],
            language_from: doc.data()['language_from'],
            type: doc.data()['type']))
        .toList();
  }

  Future<List<Category>> getCategory(courseId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('courses')
        .doc(courseId)
        .collection('categories')
        .orderBy('weight')
        .get();

    return snapshot.docs
        .map((doc) =>
        Category(
              category_id: doc.id,
              category_name: doc.data()['category_name'],
              weight: doc.data()['weight'],
            ))
        .toList();
  }

  Future<void> setCurrentCourse(courseId, userId) async {
    final ref = FirebaseFirestore.instance
        .collection('users')
        .doc(userId);

    final snapshot = await ref.get();

    if (!snapshot.exists) {
      await ref.set({'current_course': courseId});
    } else {
      await ref.update({'current_course': courseId});
    }
  }


  Future<Exercise> getExercise(courseId, exerciseId) async {
    final ref = FirebaseFirestore.instance
        .collection('courses')
        .doc(courseId)
        .collection('sentences')
        .doc(exerciseId);
    final snapshot = await ref.get();

      return Exercise.fromSnapshot(snapshot);

  }

  Future<void> addStats(stat) async {
    int _success = stat.answerFlag ? 1 : 0;
    final ref = FirebaseFirestore.instance
        .collection('users')
        .doc(stat.userId)
        .collection('statistics')
        .doc(stat.exerciseId);
    final snapshot = await ref.get();

    if (!snapshot.exists) {
      await ref.set({'total_activities': 1, 'right_answers': _success});
    } else {
      await ref.update(
          {'total_activities': snapshot['total_activities'] + 1,
            'right_answers': snapshot['right_answers'] + _success});
    }
  }
}
