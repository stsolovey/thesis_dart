import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:thesis/pages/exercise_unit.dart';

class ExPgTest2 extends StatefulWidget {
  final String courseID;
  final String categoryID;
  final int startAt;

  const ExPgTest2(
      {Key? key,
      required this.courseID,
      required this.categoryID,
      required this.startAt})
      : super(key: key);
  static const routeName = '/exercise';

  @override
  State<ExPgTest2> createState() => _ExPgTest2State();
}

class _ExPgTest2State extends State<ExPgTest2> {
  late String _sentenceId;

  void initState() {
    super.initState();
    getSentenceAndThenPush();
  }

  Future<void> getSentenceAndThenPush() async {
    await _getSentenceId().then((String result) {
      setState(() {
        _sentenceId = result;
      });

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return ExerciseUnit(
          sentenceID: result,
          courseID: widget.courseID,
          categoryID: widget.categoryID,
          startAt: widget.startAt,
        );
      }));
    });
  }

  Future<String> _getSentenceId() async {
    var data;
    try {
      data = await FirebaseFirestore.instance
          .collection('courses')
          .doc(widget.courseID)
          .collection('sentences')
          .where('id_cat', isEqualTo: widget.categoryID)
          .orderBy('sentence')
          .startAt([5])
          .limit(1)
          .get();
    } on FirebaseException catch (e) {
      print(e);
    }
    return data.docs[0].id;
  }



  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator();
  }
}
