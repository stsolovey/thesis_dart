import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart'; // for debug print
import 'package:thesis/pages/landing.dart';
//import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _fAuth = FirebaseAuth.instance;

  Future<User?> LoginWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _fAuth.signInWithEmailAndPassword(
          email: email,
          password: password);
      User? user = result.user;
      return user;
    }on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<User?> RegisterWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _fAuth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return user;
    }catch(e){
      print('registerWithEmailAndPassword Error $e');
      return null;
    }
  }

  Future recoverPassword(String email) async {
    try {
      await _fAuth.sendPasswordResetEmail(email: email);
      return true;
    }catch(e){
      print('recoverPassword Error $e');
      return false;
    }
  }

  /*Future<User?> signInWithGoogle() async {
    User? user;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
        await _fAuth.signInWithCredential(credential);

        user = userCredential.user;
        debugPrint("user: AAAA - ${user?.uid}");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          print(e);
          // handle the error here
          return null;
        }
        else if (e.code == 'invalid-credential') {
          print(e);
          // handle the error here
          return null;
        }
      } catch (e) {
        print(e);
        // handle the error here
        return null;
      }
    }

    return user;
  }*/

  Future logOut() async {
    await _fAuth.signOut();
    //return Landing();
  }

  //final GoogleSignIn googleSignIn = GoogleSignIn();

  User? get getCurrentUser {
    if (_fAuth.currentUser != null) {
      return _fAuth.currentUser;
    } else {
      return null;
    }
  }

  String get getCurrentUserUid {
    if (_fAuth.currentUser != null) {
      return _fAuth.currentUser!.uid;
    } else {
      return "None";
    }
  }

  String get getCurrentUserEmail {
    User? user = _fAuth.currentUser;
    String? email = _fAuth.currentUser!.email;
    if (user != null && email != null) {
      return email;
    } else {
      return "None";
    }
  }

  String get getCurrentUserName {
    User? user = _fAuth.currentUser;
    String? name = _fAuth.currentUser?.displayName;
    if (user != null && name != null) {
      return name;
    } else {
      return "None";
    }
  }

   Future setUserName(String name) async {
    _fAuth.currentUser?.updateDisplayName(name);
  }

  Stream<User?> get changes {
    return _fAuth.authStateChanges();
  }
}