import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timer/page/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timer/page/services/database.dart';
import 'package:timer/page/userdatalist.dart';

class ProfileHomePage extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override

  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot?>.value(
      initialData: null,
      value: DatabaseService().userdata,
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Your Profile"),
        actions: <Widget>[
          FlatButton.icon(onPressed: () async {
            await _auth.signOut();
          }, icon: Icon(Icons.person), label: Text("Logout"))
        ],
      ),
          body: UserDataList(),
    )
    );
  }
}
