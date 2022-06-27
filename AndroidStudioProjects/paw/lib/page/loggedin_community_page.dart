import 'package:flutter/material.dart';
import 'package:timer/model/userdata.dart';
import 'package:timer/page/points_form.dart';
import 'package:timer/page/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:timer/page/services/database.dart';
import 'package:timer/page/settings_form.dart';
import 'package:timer/page/userdatalist.dart';

import 'event_editing_page.dart';


class VerifiedCommunityPage extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override



  Widget build(BuildContext context) {


    return StreamProvider<List<UserData>>.value(
      initialData: [],
      value: DatabaseService().userdata,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Community"),
        ),



        body:
        UserDataList(),

      ),

    );
  }
}
