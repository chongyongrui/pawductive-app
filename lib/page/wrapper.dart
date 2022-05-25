import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer/model/user.dart';
import 'package:timer/page/authetications/authenticate.dart';
import 'package:timer/page/profile_page.dart';
import 'package:timer/page/profilehomepage.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MyUser?>(context);
    print(user);
    //return either home or authenticate widget
    if (user == null){
      return Authenticate();
    } else {
      return ProfileHomePage();
    }

  }
}
