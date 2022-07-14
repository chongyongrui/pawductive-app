import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timer/model/shared/loading.dart';
import 'package:timer/page/services/auth.dart';
import 'package:timer/globals.dart';



//sign in form for the user to sign in onto an existing firebase account

class SignIn extends StatefulWidget {
  final toggleView;
  SignIn({this.toggleView});
    @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = "";
  String password = "";
  String error = "";


  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.white,


    body: Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
      child: Form(
        key:  _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Text( "Log into your account", style: GoogleFonts.chewy(
                color: globalcolor,
                fontSize: 22.0
            )),
            SizedBox(height:20),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Email",
                fillColor: Colors.white10,
                filled: true,
              ),
              validator: (val) => val!.isEmpty ? "Enter an email" : null,
              onChanged: (val){
                setState(() => email = val);
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Password",
                fillColor: Colors.white10,
                filled: true,
              ),
              obscureText: true,
              validator: (val) => val!.length < 6 ? "Password needs to be at least 6 characters long" : null,
              onChanged: (val){
                setState(() => password = val);
              },
            ),
            SizedBox(height: 20),
            RaisedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()){
                    setState(()=> loading = true);
                    dynamic result = await _auth.SignInWithEmailAndPassword(email, password);
                    if (result==null) {

                      setState((){
                        error = 'email or password is incorrect';
                        loading = false;
                      });
                    }

                  }
                },
                color: globalcolor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),

                child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text("Log In",
                        style: GoogleFonts.chewy(
                            color: Colors.white,
                            fontSize: 22.0
                        )
                    )
                )
            ),
            SizedBox(height: 12,),
            Text(
              error,
              style: TextStyle(color: Colors.red, fontSize: 14.0),
            ),
            SizedBox(height: 150),
            Text( "Don't have an account?", style: GoogleFonts.chewy(
                color: globalcolor,
                fontSize: 22.0
            )),
            SizedBox(height: 20),
            RaisedButton(
            onPressed: () {
              widget.toggleView();
            },
            color: globalcolor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
            ),

            child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Text("Sign Up here",
                    style: GoogleFonts.chewy(
                        color: Colors.white,
                        fontSize: 22.0
                    )
                )
            )
        ),



      ]),
    ),
    ));
  }
}
