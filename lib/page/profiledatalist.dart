import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timer/model/shared/loading.dart';
import 'package:timer/model/user.dart';
import 'package:timer/model/userdata.dart';
import 'package:timer/page/userwidget.dart';
import 'package:timer/page/services/database.dart';
import 'dart:math';

class ProfileDataList extends StatefulWidget {
  @override
  _ProfileDataListState createState() => _ProfileDataListState();
}

class _ProfileDataListState extends State<ProfileDataList> {
  @override
  Widget build(BuildContext context) {
    MyUser user = Provider.of<MyUser>(context);


    return StreamBuilder<Userdetails>(
        stream: DatabaseService(uid: user.uid).userInfo,
        builder: (context, snapshot) {

          if (snapshot.hasData) {
            Userdetails? userinfo = snapshot.data;
            int level = sqrt((userinfo?.level)!.toInt()).ceil();
            return Column(children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 8.0),
                child: Card(
                  margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(userinfo!.url),
                      //backgroundColor: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
                    ),
                    title: Text((userinfo?.name).toString()),
                    subtitle: Text("Level: ${(level.ceil())} \n"
                        "Points: ${userinfo?.points}"),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20.0),
                child: Text(
                  "Unlocked Achievements",
                  style: GoogleFonts.chewy(fontSize: 20, color: Colors.blue),
                ),
              ),





              Container(
                margin: const EdgeInsets.symmetric(vertical: 20.0),
                height: 200.0,
                child: ListView(
                  // This next line does the trick.
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[












                    Container(
                      width: 160.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/gif1.gif'
                              ),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Text(""),
                    ),







                    Container(
                      width: 160.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(imageHider(level,10, 2)
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Text("Unlocked at level 10"),
                    ),




                    Container(
                      width: 160.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(imageHider(level,20, 3)
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Text("Unlocked at level 20"),
                    ),
                    Container(
                      width: 160.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(imageHider(level,30, 4)
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Text("Unlocked at level 30"),
                    ),
                    Container(
                      width: 160.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(imageHider(level,40, 5)
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Text("Unlocked at level 40"),
                    ),
                    Container(
                      width: 160.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(imageHider(level,50, 6)
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Text("Unlocked at level 50",),
                    ),
                  ],
                ),
              ),
            ]);
          } else {
            return Loading();
          }
        });
  }

  String imageHider (int level, int minlevel ,int picnumber) {
    if ( level >= minlevel ) {
      return "assets/images/gif$picnumber.gif";
    } else {
      return "assets/images/Question.png";
    }
  }

}
