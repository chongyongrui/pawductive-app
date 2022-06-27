import 'package:flutter/material.dart';
import 'package:timer/model/userdata.dart';
import 'dart:math';

class userwidget extends StatelessWidget {
  final UserData userdetails;

  userwidget({required this.userdetails});




  @override

  
  Widget build(BuildContext context) {
    int level = ((userdetails?.xp)!.toInt() / 100).ceil();
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child:
        ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundImage: NetworkImage((userdetails?.url).toString()),
          ),
          title: Text((userdetails?.name).toString()),
          subtitle: Text("Level: ${(level.ceil())} \n"
              "XP: ${(userdetails?.xp)!.toInt() % 100} / 100 \n"
              "Points: ${userdetails?.points}"),

        ),
      ),
    );
  }
}

