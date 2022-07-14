import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer/globals.dart';
import 'package:timer/model/shared/loading.dart';
import 'package:timer/model/user.dart';
import 'package:timer/page/services/database.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import 'package:path/path.dart' as path;
import 'package:timer/page/services/storage_service.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';


class SettingsForm extends StatefulWidget {

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  Future pickImage() async{
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image==null) return;
  }
  
  final _formKey = GlobalKey<FormState>();
  String? _currentName;
  int? _currentlevel;
  int? _currentxp;
  int? _currentpoints;
  String? _currentUrl;

  
  
  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    MyUser user = Provider.of<MyUser>(context);
    File? storedImage;

    return StreamBuilder<Userdetails>(
      stream: DatabaseService(uid: user.uid ).userInfo,
      builder: (context, snapshot) {

        if(snapshot.hasData){
          Userdetails? userinfo = snapshot.data;

          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                      crossAxisAlignment: CrossAxisAlignment.center ,//Center Row contents vertically,
                    children: [
                      GestureDetector(
                        onTap: () => pickColor1(context),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: globalcolor,
                          ),
                          width: 50,
                          height: 50,
                        ),
                      ),

                      SizedBox(height: 30,width: 30,),
                      GestureDetector(
                        onTap: () => pickColor2(context),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: globalcolor,
                          ),
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ],
                  ),
                ),



                TextFormField(
                  initialValue: userinfo?.name,
                  decoration: InputDecoration(
                    hintText: "Your new profile name",
                    fillColor: Colors.white10,
                    filled: true,
                  ),
                  validator: (val) => val!.isEmpty ? "Please enter a name" :null,
                  onChanged: (val) => setState(()=> _currentName = val) ,
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
                SizedBox(height: 20.0,),
                RaisedButton(
                  color: globalcolor,
                  child: Text(
                    "Update",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()){
                      await DatabaseService(uid: user.uid).updateUserData(
                          _currentName ?? userinfo!.name,
                          _currentlevel ?? userinfo!.level,
                          _currentxp ?? userinfo!.xp,
                          _currentpoints ?? userinfo!.points,
                        _currentUrl ?? userinfo!.url,
                        picturenumber ?? userinfo!.picnum,


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

  Widget buildColor1Picker() => ColorPicker(
      pickerColor: globalcolor,
      onColorChanged: (color) => setState(() => globalcolor = color),);

 void pickColor1(BuildContext context) => showDialog(
     context: context,
     builder: (context) => AlertDialog(
       title: Text("Pick the first theme color"),
       content: Column(
         children: [
           buildColor1Picker(),
           TextButton(
             child: Text(
               'SELECT',
               style: TextStyle(fontSize: 20),
             ),
             onPressed: () => Navigator.of(context).pop(),
           ),
         ],
       ),
     ),
 );

  Widget buildColor2Picker() => ColorPicker(
    pickerColor: globalcolor,
    onColorChanged: (color) => setState(() => globalcolor2 = color),);

  void pickColor2(BuildContext context) => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text("Pick the second theme color"),
      content: Column(
        children: [
          buildColor1Picker(),
          TextButton(
            child: Text(
              'SELECT',
              style: TextStyle(fontSize: 20),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    ),
  );


     



}
