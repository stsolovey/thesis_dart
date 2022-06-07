import 'package:cloud_firestore/cloud_firestore.dart';

class ExerciseGenerator {
  Future<String> generateExercise(courseId, categoryId) async {
    var data = await FirebaseFirestore.instance
        .collection('courses')
        .doc(courseId)
        .collection('sentences')
        .where('id_cat', isEqualTo: categoryId)
        .limit(1)
        .get();
    var document = data.docs[0];
    String sent = document['sentence'];
    print(sent);
    return data.docs[0].id;
  }
}
