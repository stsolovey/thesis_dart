import 'package:flutter/material.dart';
//import 'package:thesis/layout/app_bar.dart';
import 'package:thesis/services/auth_service.dart';


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override

  _UserInfoState createState() => _UserInfoState();
}
void _logOut(){
  AuthService _aService = AuthService();
  _aService.logOut();
}
class _UserInfoState extends State<Profile> {
  final AuthService _aService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(_aService.getCurrentUserName),
        actions: const [
          /*IconButton(
        icon: Icon(Icons.face),
        onPressed: _userMenu,
      ),*/
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: _logOut,
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.face_rounded),
            title: TextFormField(
                initialValue: _aService.getCurrentUserName,
                onChanged: (text){
                  _aService.setUserName(text);
                }
            )
          ),
          ListTile(
            leading: const Icon(Icons.perm_identity),
            title: Text(_aService.getCurrentUserUid),
          ),
          ListTile(
            leading: const Icon(Icons.alternate_email),
            title: Text(_aService.getCurrentUserEmail),
          ),

        ],
      )
    );
  }
}
