import 'package:firebase_auth/firebase_auth.dart';
import 'package:timer/model/user.dart';

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

  // register with email and password

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