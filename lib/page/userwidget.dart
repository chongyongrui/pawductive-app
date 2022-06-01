import 'package:flutter/material.dart';
import 'package:timer/model/userdata.dart';

class userwidget extends StatelessWidget {
  final UserData userdetails;
  userwidget({required this.userdetails});


  @override

  
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child:
        ListTile(
          leading: CircleAvatar(
            radius: 25.0,
              backgroundColor: Colors.white,
          ),
          title: Text((userdetails?.name).toString()),
          subtitle: Text("Level ${userdetails?.level} \n ${userdetails?.points} points"),

        ),
      ),
    );
  }
}

