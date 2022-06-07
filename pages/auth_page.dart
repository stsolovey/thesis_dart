import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:thesis/pages/landing.dart';
import 'package:thesis/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthPage extends StatelessWidget {

  Duration get loginTime => Duration(milliseconds: 2250);

  final AuthService _authService = AuthService();

  Future<String?> _authUser(LoginData data) async{
    User? user = await _authService.LoginWithEmailAndPassword(data.name, data.password);
    return Future.delayed(loginTime).then((_)  {
      if (user == null) {
        return 'User not exists or password does not match';
      }
      return null;
    });
  }

  Future<String?> _signupUser(SignupData data) async{
    await _authService.RegisterWithEmailAndPassword(data.name!, data.password!);
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  Future<String?> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (true) {
        return 'User not exists';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'THESIS',
      logo: const AssetImage('assets/images/icon.png'),
      onLogin: _authUser,
      onSignup: _signupUser,

      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Landing(),
        ));
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}