import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:timer/globals.dart';
import 'package:timer/model/shared/loading.dart';
import 'package:timer/model/user.dart';
import 'package:timer/model/userdata.dart';
import 'package:timer/page/services/database.dart';


class SettingsForm extends StatefulWidget {

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  
  final _formKey = GlobalKey<FormState>();
  late String? _currentName;
  late int _currentlevel;
  late int _currentpoints;

  
  
  @override
  Widget build(BuildContext context) {

    MyUser user = Provider.of<MyUser>(context);

    return StreamBuilder<Userdetails>(
      stream: DatabaseService(uid: user.uid ).userInfo,
      builder: (context, snapshot) {

        if(snapshot.hasData){
          Userdetails? userinfo = snapshot.data;

          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text("Update your profile name"),
                SizedBox(height: 20),
                TextFormField(
                  initialValue: userinfo?.name,
                  decoration: InputDecoration(
                    hintText: "Your new profile name",
                    fillColor: Colors.white10,
                    filled: true,
                  ),
                  validator: (val) => val!.isEmpty ? "Please enter a name" :null,
                  onChanged: (val) => setState(()=> _currentName=val) ,
                ),
                SizedBox(height: 20.0,),
                //dropdown
                //slider, user profile pic?
                Text("Default timer duration:"),
                Slider(
                  value: globalTimechosen.roundToDouble(),
                  min: 10,
                  max: 200,
                  divisions: 19,
                  onChanged: (val) => setState(()=> globalTimechosen = val.round()) ,
                ),
                Text("$globalTimechosen minutes"),
                RaisedButton(
                  color: Colors.blue,
                  child: Text(
                    "Update",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()){
                      await DatabaseService(uid: user.uid).updateUserData(
                          _currentName ?? "New pawductive user",
                          _currentlevel ?? 1,
                          _currentpoints ?? 0,


                      );
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          );

        } else {

      return Loading();

       }


    }
    );
  }
}
