import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDataList extends StatefulWidget {
  const UserDataList({Key? key}) : super(key: key);

  @override
  State<UserDataList> createState() => _UserDataListState();
}

class _UserDataListState extends State<UserDataList> {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<QuerySnapshot>(context);
    //print(userData.docs);

    for (var doc in userData.docs){
      print(userData.docs);
    }

    return Container();
  }
}

