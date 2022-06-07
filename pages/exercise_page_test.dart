import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:thesis/pages/exercise_unit.dart';

class ExPgTest extends StatelessWidget {
  final String courseID;
  final String categoryID;
  final int startAt;
  const ExPgTest({Key? key, required this.courseID, required this.categoryID, required this.startAt}) : super(key: key);



  Future<String> _getSentenceId() async {
    var data;
    try {
      data = await FirebaseFirestore.instance
          .collection('courses')
          .doc(courseID)
          .collection('sentences')
          .where('id_cat', isEqualTo: categoryID)
          .orderBy('sentence')
          .startAt([startAt])
          .limit(1)
          .get();

    } on FirebaseException catch (e) {
      print(e);
    }
    return data.docs[0].id;
  }


  FutureBuilder _futureBuilder(){
    final Future<String> _sentenceID = _getSentenceId();
    return FutureBuilder<String>(
      future: _sentenceID, // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          children = <Widget>[
            Flexible(
              child: ExerciseUnit(
                sentenceID: '${snapshot.data}',
                courseID: courseID,
                categoryID: categoryID,
                startAt: startAt,
              ),
            ),

            //Text('Result ${snapshot.data}')
          ];
        } else if (snapshot.hasError) {
          children = <Widget>[
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Error: ${snapshot.error}'),
            )
          ];
        } else {
          children = const <Widget>[
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(),
            ),
          ];
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          ),
        );
      },
    );
  }
  @override



  Widget build(BuildContext context) {
    _futureBuilder();
    return _futureBuilder();
  }
}
