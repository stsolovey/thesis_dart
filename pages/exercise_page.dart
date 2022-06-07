/*import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:thesis/pages/exercise_unit.dart';

class ExercisePage extends StatefulWidget {
  final String courseID;
  final String categoryID;

  const ExercisePage(
  {Key? key, required this.courseID, required this.categoryID})
      : super(key: key);
  static const routeName = '/exercise';

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {

  late String _sentenceID;
  late ExerciseUnit _exUnit;

  void initState() {
    super.initState();
    _getSentenceId();
    print('init state is working $_sentenceID');
    _setExerciseUnit();
  }

  Future<void> _getSentenceId() async {

    var data = await FirebaseFirestore.instance
        .collection('courses')
        .doc(widget.courseID)
        .collection('sentences')
        .where('id_cat', isEqualTo: widget.categoryID)
        //.orderBy('')
        //.startAt([1])
        //.limit(1)
        .get();
    setState(() {
      _sentenceID = data.docs[0].id;
      print('setState is working $_sentenceID');

    });
  }

  Future<void> _setExerciseUnit() async {
    print('_setExerciseUnit is working $_sentenceID');
    _exUnit = ExerciseUnit(
      sentenceID: _sentenceID,
      courseID: widget.courseID,
      categoryID: widget.categoryID,
    );
  }

  Future<String> _getSentenceIdString() async {

    var data = await FirebaseFirestore.instance
        .collection('courses')
        .doc(widget.courseID)
        .collection('sentences')
        .where('id_cat', isEqualTo: widget.categoryID)
    //.orderBy('')
    //.startAt([1])
    //.limit(1)
        .get();
    return data.docs[0].id;
  }

  Future<ExerciseUnit> _setExerciseUnit2() async {
    print('_setExerciseUnit is working $_sentenceID');
    return ExerciseUnit(
      sentenceID: _sentenceID,
      courseID: widget.courseID,
      categoryID: widget.categoryID,
    );
  }

  @override

  Widget build(BuildContext context) {
    print('_ExercisePageState is working $_sentenceID');
    return _exUnit;
  }
}
*/