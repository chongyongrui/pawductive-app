import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timer/model/userdata.dart';
import 'package:timer/page/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timer/page/services/database.dart';
import 'package:timer/page/settings_form.dart';
import 'package:timer/page/userdatalist.dart';
import 'package:timer/page/userwidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';




class ProfileHomePage extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override



  Widget build(BuildContext context) {

    void _ShowSettingsPanel (BuildContext context){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
          child: SettingsForm(),
        );
      });
    }



    return StreamProvider<List<UserData>>.value(
      initialData: [],
      value: DatabaseService().userdata,
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Your Profile"),
        actions: <Widget>[

          FlatButton.icon(
            icon: Icon(Icons.settings),
            label: Text("Settings"),
            onPressed: () => _ShowSettingsPanel(context),
          ),
          FlatButton.icon(onPressed: () async {
            await _auth.signOut();
          }, icon: Icon(Icons.person), label: Text("Logout")
          ),
        ],
      ),
          body:
          UserDataList(),


            ),

    );
  }
}
