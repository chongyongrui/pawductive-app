import 'package:flutter/material.dart';
import 'package:timer/globals.dart';
import 'package:timer/model/userdata.dart';
import 'package:timer/page/points_form.dart';
import 'package:timer/page/profiledatalist.dart';
import 'package:timer/page/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:timer/page/services/database.dart';
import 'package:timer/page/settings_form.dart';

class ProfileHomePage extends StatefulWidget {
  @override
  State<ProfileHomePage> createState() => _ProfileHomePageState();
}

class _ProfileHomePageState extends State<ProfileHomePage> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _ShowSettingsPanel(BuildContext context) {
      showModalBottomSheet(
          context: context,
          builder: (context) {
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
          backgroundColor: globalcolor,
          title: Text("Your Profile"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),

              onPressed: () => setState((){
                globalcolor=globalcolor;
                globalcolor2=globalcolor2;
              }),
            ),
            IconButton(
              icon: Icon(Icons.settings),

              onPressed: () => _ShowSettingsPanel(context),
            ),
            TextButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: Icon(Icons.person),
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white)
                ),
                label: Text("Logout")),
          ],
        ),
        body: ProfileDataList(),

      ),
    );
  }
}


