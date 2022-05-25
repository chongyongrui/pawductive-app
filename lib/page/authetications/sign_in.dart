import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timer/page/services/auth.dart';


class SignIn extends StatefulWidget {

    @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  //text field state
  String email = "";
  String password = "";



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,


    body: Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
      child: Form(
        child: Column(
          children: <Widget>[

            SizedBox(height:20),
            TextFormField(
              onChanged: (val){
                setState(() => email = val);
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              obscureText: true,
              onChanged: (val){
                setState(() => password = val);
              },
            ),
            SizedBox(height: 30),
            RaisedButton(
                onPressed: () async {
                  print(email);
                  print(password);
                },
                color: Colors.blue,
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
            )

          ],
        ),
      ),
    ),
    );
  }
}
