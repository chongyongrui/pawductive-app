import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer/model/userdata.dart';
import 'package:timer/page/userwidget.dart';

class UserDataList extends StatefulWidget {
  @override
  _UserDataListState createState() => _UserDataListState();
}

class _UserDataListState extends State<UserDataList> {
  @override
  Widget build(BuildContext context) {
    final userdata = Provider.of<List<UserData>>(context) ?? [];


    return ListView.builder(
        itemCount: userdata.length,
        itemBuilder: (context,index) {
          return
          userwidget(userdetails: userdata[index]);
        },
    );
  }
}

