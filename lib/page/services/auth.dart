import 'package:firebase_auth/firebase_auth.dart';
import 'package:timer/model/user.dart';
import 'package:timer/page/services/database.dart';


//auth service to authenticate to firebase

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  // create MyUser object based on User
  MyUser? _userfromFirebase(User? user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }


  //auth change user stream
  Stream<MyUser?> get user {
    return _auth.authStateChanges()
    .map(_userfromFirebase);
  }

  //sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userfromFirebase(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }


  //sign in email and password

  Future SignInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userfromFirebase(user);

    } catch(e){
      print(e.toString());
      return null;
    }

  }

  // register with email and password
  
  Future registerWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      //create a new document for user with uid
      await DatabaseService(uid: user!.uid).updateUserData("new user",0,1);
      return _userfromFirebase(user);

    } catch(e){
      print(e.toString());
      return null;
    }
      
  }
  
  

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e){
      print(e.toString());
      return null;
    }
  }
}