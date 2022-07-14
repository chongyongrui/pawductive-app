import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timer/globals.dart';
import 'package:timer/model/shared/loading.dart';
import 'package:timer/model/user.dart';
import 'package:timer/page/services/database.dart';

class PointsEditingPage extends StatefulWidget {
  @override
  State<PointsEditingPage> createState() => _PointsEditingPageState();
}

class _PointsEditingPageState extends State<PointsEditingPage> {
  final _formKey = GlobalKey<FormState>();
  String? _currentName;
  int _currentlevel = 0;
  int _currentxp = 0;
  int _currentpoints = 0;
  String? _currentUrl;

  @override
  Widget build(BuildContext context) {
    MyUser user = Provider.of<MyUser>(context);

    return StreamBuilder<Userdetails>(
        stream: DatabaseService(uid: user.uid).userInfo,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Userdetails? userinfo = snapshot.data;

            return Material(
                type: MaterialType.transparency,
                child: new Form(
              key: _formKey,
              child: Column(
                children: <Widget>[

                  SizedBox(height: 20),
                  Column(
                    children: [
                      Image.asset(globalpicsource,
                        width: 200,
                        height: 200,),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text("Good Job!",style: GoogleFonts.chewy(
                      color: globalcolor,
                      fontSize: 22.0
                  )),

                  SizedBox(height: 20),


                  //dropdown
                  //slider, user profile pic?

                  Text("$globalpoints points gained in this session",style: GoogleFonts.chewy(
                      color: globalcolor,
                      fontSize: 22.0
                  )),

                  SizedBox(
                    height: 20.0,
                  ),

                  RaisedButton(
                      color: globalcolor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),

                      child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text("Upload Points",
                              style: GoogleFonts.chewy(
                                  color: Colors.white,
                                  fontSize: 22.0
                              )
                          )
                      ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _currentxp = userinfo!.xp + globalpoints;
                        _currentpoints = userinfo!.points + globalpoints;
                        _currentlevel = userinfo!.level + globalpoints;
                        globalpoints = 0;

                        await DatabaseService(uid: user.uid).updateUserData(
                          _currentName ?? userinfo!.name,
                          _currentlevel ?? userinfo!.level,
                          _currentxp ?? userinfo!.xp,
                          _currentpoints ?? userinfo!.points,
                          _currentUrl ?? userinfo!.url,
                          userinfo!.picnum,
                        );
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            ))
            ;
          } else {
            return Loading();
          }
        });
  }
}
