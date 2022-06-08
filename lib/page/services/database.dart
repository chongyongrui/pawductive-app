import "package:cloud_firestore/cloud_firestore.dart";
import 'package:timer/model/user.dart';
import 'package:timer/model/userdata.dart';

class DatabaseService {

  final String? uid;
  DatabaseService( {this.uid});

  //collection reference
  final CollectionReference userDataCollection = FirebaseFirestore.instance.collection("User Data");

  Future <void> updateUserData( String name, int points, int level, String url) async {
    return await userDataCollection.doc(uid).set({
      "name" : name,
     "points" : points,
      "level" : level,
      "url" : url,
  });
}


// UserData list  from snapshot
  List<UserData> _UserDataListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return UserData(

        name: doc.get('name') ?? 'new user',
        points: doc.get('points') ?? 0,
        level: doc.get('level') ?? 1,
        url: doc.get('url') ?? 'https://www.kindpng.com/picc/m/207-2074624_white-gray-circle-avatar-png-transparent-png.png'


      );
    }).toList();
  }


  //userData from snapshot
  Userdetails _userInfoFromSnapshot(DocumentSnapshot snapshot){
    return Userdetails(
      uid: uid,
      name: snapshot['name'],
      level: snapshot["level"],
      points: snapshot["points"],
      url: snapshot["url"]
    );
  }

//get UserData stream

  Stream<List<UserData>> get userdata {
    return userDataCollection.snapshots().map(_UserDataListFromSnapshot);
  }

  //get user doc stream
  Stream<Userdetails> get userInfo {
    return userDataCollection.doc(uid).snapshots().map(_userInfoFromSnapshot);
  }

}