import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer/globals.dart';
import 'package:timer/model/shared/loading.dart';
import 'package:timer/model/user.dart';
import 'package:timer/page/services/database.dart';


class PointsEditingPage extends StatefulWidget {

  @override
  State<PointsEditingPage> createState() => _PointsEditingPageState();
}

class _PointsEditingPageState extends State<PointsEditingPage> {

  final _formKey = GlobalKey<FormState>();
  String? _currentName;
  int _currentlevel =0;
  int _currentpoints =0;
  String? _currentUrl;



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
                  Text("Click here to upload your new points"),



                  SizedBox(height: 20),

                  SizedBox(height: 20.0,),
                  //dropdown
                  //slider, user profile pic?

                  Text("$globalpoints points gained in this session"),
                  RaisedButton(
                    color: Colors.blue,
                    child: Text(
                      "Upload",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()){


                          _currentpoints = userinfo!.points + globalpoints;
                          _currentlevel = userinfo!.level + globalpoints;
                          globalpoints = 0;


                        await DatabaseService(uid: user.uid).updateUserData(
                          _currentName ?? userinfo!.name,
                          _currentlevel ?? userinfo!.level,
                          _currentpoints ?? userinfo!.points,
                         _currentUrl ?? userinfo!.url,



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
