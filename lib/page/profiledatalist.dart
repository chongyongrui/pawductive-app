import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timer/model/shared/loading.dart';
import 'package:timer/model/user.dart';
import 'package:timer/model/userdata.dart';
import 'package:timer/page/points_form.dart';
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
            int level = ((userinfo?.xp)!.toInt() / 100).ceil();
            int pics = (userinfo?.picnum)!.toInt();
            return Column(children: <Widget>[
              GestureDetector(
            onTap: () {
              //do what you want here


              setState ((){
                globalcolor2= globalcolor2;
                globalcolor = globalcolor;
              });



            },
                child: Container(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Card(
                    margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 25.0,
                        backgroundImage: Image.asset("assets/images/gif$pics.gif").image
          ,
                        //backgroundColor: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.5),
                      ),
                      title: Text((userinfo?.name).toString()),
                      subtitle: Text("Level: ${(level.ceil())} \n"
                      "XP: ${(userinfo?.xp)!.toInt() % 100} / 100 \n"
                          "Points: ${userinfo?.points}"),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 40.0),
                child: Text(
                  "Unlocked Animations",
                  style: GoogleFonts.chewy(fontSize: 20, color: globalcolor),
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
              Container(
                    child: Column(
                        children: <Widget> [
                          RaisedButton(
                              onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => PointsEditingPage())),
                              color: globalcolor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100.0),
                              ),

                              child: Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Text("Upload Earned Points",
                                      style: GoogleFonts.chewy(
                                          color: Colors.white,
                                          fontSize: 22.0
                                      )
                                  )
                              )
                          )
                        ]
                    )
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

  Widget gifimage(int imagenum, int piclevel, int level) {
    return Column(
      children: [
        GestureDetector(

          onTap: () {
            //do what you want here

            changetimerpic(imagenum, level, piclevel);
            picturenumber = imagenum;
            setState ((){
              picturenumber = imagenum;
            });



          },
          child: Container(
            width: 190.0,
            height: 190.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imageHider(level, piclevel, imagenum)),
                fit: BoxFit.fill,
              ),
              border: Border.all(
                color: (picturenumber==imagenum) ? Colors.black : Colors.transparent,
                width: 6,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text("Unlocked at level $piclevel"),
          ),
        )
      ],
    );
  }
}
