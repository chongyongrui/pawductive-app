import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timer/page/services/auth.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
                      child: Text("Sign Up",
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
