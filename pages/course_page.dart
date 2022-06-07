import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:thesis/pages/user_page.dart';
import 'package:thesis/services/auth_service.dart';
import 'exercise_page_test_2.dart';


class CoursePage extends StatefulWidget {
  final openedCategory = 2;
  final String courseID;
  final String  courseName;

  const CoursePage({Key? key, required this.courseID, required this.courseName}) : super(key: key);
  static const routeName = '/course';

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  String? _catID;
  void _getCategoryId(weight) async {

    var data = await FirebaseFirestore.instance
        .collection('courses')
        .doc(widget.courseID)
        .collection('categories')
        .where('weight', isEqualTo: weight)
        .limit(1)
        .get();
    setState(() {
      _catID = data.docs[0].id; //because the query returns a list of docs, even if the result is 1 document. You need to access it using index[0].
    });
    //print(_catID);
  }
  void initState() {
    _getCategoryId(widget.openedCategory);
  }

  void _userMenu() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return const Profile();
    }));
  }

  void _logOut() {
    AuthService _aService = AuthService();
    _aService.logOut();
  }

  void _startExercise(categoryID){
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ExPgTest2(courseID: widget.courseID, categoryID: categoryID, startAt: 1,);
    }));
  }



  @override
  Widget build(BuildContext context) {
    //final args = ModalRoute.of(context)!.settings.arguments as CourseArguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.courseName),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: _userMenu,
          ),
          IconButton(
            icon: Icon(Icons.outbond_outlined),
            onPressed: _logOut,
          ),
        ],
      ),
      //ToDo remove StreamBuilder
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('courses')
            .doc(widget.courseID)
            .collection('categories')
            .orderBy('weight')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Text('Нет записей',
                style: TextStyle(color: Colors.white));
          }
          return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  key: Key(snapshot.data!.docs[index].id),
                  child: ListTile(
                      enabled: snapshot.data!.docs[index].get('weight') <= widget.openedCategory ? true : false, // ToDo a lot of work
                      title: Row(children: [
                        Text(snapshot.data!.docs[index].get('category_name')),
                      ]),
                      trailing: true
                          ? IconButton(
                              icon: const Icon(Icons.arrow_forward),
                              onPressed: () {
                                String categoryID = snapshot.data!.docs[index].id.toString();
                                _startExercise(categoryID);
                              },
                            )
                          : Text('...'),
                      onTap: () {
                        String categoryID = snapshot.data!.docs[index].id.toString();
                        _startExercise(categoryID);
                      },
                      onLongPress: () {}),
                );
              });
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: Text("Next"),
        onPressed: () async {
          _getCategoryId(widget.openedCategory);

          if (_catID != null) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              print('Navigator $_catID');
              return ExPgTest2(
                courseID: widget.courseID,
                categoryID: _catID!,
                  startAt: 1,
              );
            }));
          }
        },
      ),
    );
  }
}
