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

import '../globals.dart';

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
                padding: EdgeInsets.only(top: 40.0),
                child: Text(
                  "Unlocked Animations",
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
                    gifimage(1, 0, level),
                    gifimage(2, 5, level),
                    gifimage(3, 10, level),
                    gifimage(4, 15, level),
                    gifimage(5, 20, level),
                    gifimage(6, 30, level),
                    gifimage(7, 40, level),
                    gifimage(8, 50, level),
                    gifimage(9, 60, level),
                    gifimage(10, 70, level),

                  ],
                ),
              ),
            ]);
          } else {
            return Loading();
          }
        });
  }

  String imageHider(int level, int minlevel, int picnumber) {
    if (level >= minlevel) {
      return "assets/images/gif$picnumber.gif";
    } else {
      return "assets/images/Question.png";
    }
  }

  void changetimerpic(int picnum, int currlevel, int minlevel) {
    if (currlevel >= minlevel) {
      globalpicsource = "assets/images/gif$picnum.gif";


    } else {
      globalpicsource = "assets/images/corgi.png";
    }
    //setState();
  }

  Widget gifimage (int imagenum, int piclevel, int level){
    return Column(

      children: [
        GestureDetector(
          onTap: () {
            //do what you want here
            changetimerpic(imagenum,level,piclevel);
          },
          child: Container(
            width: 190.0,
            height: 190.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imageHider(level, piclevel, imagenum)),
                fit: BoxFit.fill,
              ),
            ),
            child: Text("Unlocked at level $piclevel"),

          ),
        )
      ],
    );
  }

}


