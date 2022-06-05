import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timer/model/shared/loading.dart';
import 'package:timer/page/services/auth.dart';


//form for a user to register an account on that is saved on firebase

class Register extends StatefulWidget {
  final toggleView;
  Register({this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = "";
  String password = "";
  String error ="";

  @override
  Widget build(BuildContext context) {
    return loading ? Loading():  Scaffold(
      backgroundColor: Colors.white,


      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              Text( "Create an account", style: GoogleFonts.chewy(
                  color: Colors.blue,
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
                      setState(()=>loading = true);
                      dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                      if (result==null) {
                        setState((){
                          error = 'please supply a valid email';
                          loading = false;
                        });
                      }
                    }
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
              ),

              SizedBox(height: 12,),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),

              SizedBox(height: 150),
              Text( "Already have an account?", style: GoogleFonts.chewy(
                  color: Colors.blue,
                  fontSize: 22.0
              )),
              SizedBox(height: 20),

              RaisedButton(
                  onPressed: () {
                   widget.toggleView();
                  },
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),

                  child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text("Sign in here",
                          style: GoogleFonts.chewy(
                              color: Colors.white,
                              fontSize: 22.0
                          )
                      )
                  )
              ),

            ],
          ),
        ),
      ),
    );
  }
}
