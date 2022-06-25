import "package:flutter/material.dart";
import 'package:timer/page/authetications/register.dart';
import 'package:timer/page/authetications/sign_in.dart';


//firebase authentication of the user

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  toggleView(){
    setState(( )=> showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {

      if (showSignIn == true) {
        return SignIn(toggleView:toggleView);
    } else {
        return Register(toggleView:toggleView);
    }

  }
}

