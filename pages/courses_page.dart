import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:thesis/pages/course_page.dart';
import 'package:thesis/pages/exercise_page_test.dart';
import 'package:thesis/pages/user_page.dart';
import 'package:thesis/services/auth_service.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({Key? key}) : super(key: key);
  static const routeName = '/courses';

  @override
  _CoursesPageState createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  void _userMenu() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return Profile();
    }));
  }

  void _logOut() {
    AuthService _aService = AuthService();
    _aService.logOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses'),
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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('courses').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return const Text('Нет записей',
                style: TextStyle(color: Colors.white));
          return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  key: Key(snapshot.data!.docs[index].id),
                  child: ListTile(
                    title: Row(children: [
                      Expanded(
                        child: Text(snapshot.data!.docs[index].get('name')),
                      ),
                      Text(snapshot.data!.docs[index].get('language_from')),
                      const Text('-'),
                      Text(snapshot.data!.docs[index].get('language_to')),
                    ]),
                    trailing: IconButton(
                      icon: const Icon(Icons.arrow_forward),
                      onPressed: () {
                        var courseID = snapshot.data!.docs[index].id.toString();
                        var courseName = snapshot.data!.docs[index].get('name');

                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CoursePage(
                              courseID: courseID, courseName: courseName);
                        }));
                      },
                    ),
                  ),
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('test'),
        onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) {
              return ExPgTest(courseID: 'base', categoryID: '0Das6OSeQPxl6edgmqVg', startAt: 0,);
            }));
      },

      ),
    );
  }
}
