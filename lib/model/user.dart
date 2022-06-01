import 'package:timer/model/userdata.dart';

class MyUser {
  final String uid ;
  MyUser ({ required this.uid });

}

class Userdetails {

  final String? uid;
  final String name;
  final int level;
  final int points;

  Userdetails({ required this.uid, required this.name, required this.level, required this.points});
}