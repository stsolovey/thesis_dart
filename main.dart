import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:thesis/services/auth_service.dart';
import 'package:thesis/material_app.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
      apiKey: "AIzaSyDn7-MjvKQnyxxy44BS2kbQuQh5hEK0FVM",
      appId: "1:889189646850:web:c8f76fb4ccb6f180689d1b",
      messagingSenderId: "889189646850",
      projectId: "thesis-28426",
    ),
  );
  runApp(const thesisApp());
}

// ignore: camel_case_types
class thesisApp extends StatelessWidget {
  const thesisApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return StreamProvider<User?>.value(
      value: AuthService().changes,
      initialData: AuthService().getCurrentUser,
      child: const MaterialAppClass(),
    );
  }
}




