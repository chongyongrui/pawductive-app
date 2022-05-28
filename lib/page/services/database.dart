import "package:cloud_firestore/cloud_firestore.dart";

class DatabaseService {

  final String? uid;
  DatabaseService( {this.uid});
  //collection reference
  final CollectionReference UserDataCollection = FirebaseFirestore.instance.collection("User Data");

  Future updateUserData(int points, int level) async {
    return await UserDataCollection.doc(uid).set({
     "points" : points,
      "level" : level,
  });
}

//get the user data stream

  Stream<QuerySnapshot> get userdata {
    return UserDataCollection.snapshots();
  }

}