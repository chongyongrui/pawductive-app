import 'package:flutter/material.dart';
import 'package:timer/page/services/auth.dart';

class ProfileHomePage extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Your Profile"),
        actions: <Widget>[
          FlatButton.icon(onPressed: () async {
            await _auth.signOut();
          }, icon: Icon(Icons.person), label: Text("Logout"))
        ],
      ),
    );
  }
}
