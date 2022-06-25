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

                IconButton(
                  icon: Image.network((userinfo?.url).toString()),
                  iconSize: 50,
                  onPressed: () async {
                   // final image = await ImagePicker().pickImage(source: ImageSource.gallery);



                    final image = await FilePicker.platform.pickFiles(
                      allowMultiple: false,
                      type: FileType.custom,
                      allowedExtensions: ['png','jpg'],

                    );


                    if (image==null) return;

/*
                    setState(() {
                      storedImage = File(image!.path);
                    });
                    final appDir = await syspaths.getApplicationDocumentsDirectory();
                    final fileName = path.basename(image!.path);
                    final savedImage = await  File(image.path).copy('${appDir.path}/$fileName');

 */

                    final path = image.files.single.path!;
                    final fileName = image.files.single.name;



                    storage.uploadFile(path, fileName).then((value) => print("done"));
                    final storageRef = FirebaseStorage.instance.ref();
                    final pathReference = storageRef.child(fileName);
                    final gsReference =
                    FirebaseStorage.instance.refFromURL("gs://test/$fileName");
                    print(path);
                    print(fileName);
                    print(gsReference);
                    _currentUrl = gsReference.toString();
                    print(_currentUrl);



                   // _currentUrl = (storage.downloadURL(fileName)).toString();




                    //upload image

                   // locator.get<UserController>().uploadProfilePic();


                  },
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
                  color: Colors.blue,
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
                        userinfo!.picnum,


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
