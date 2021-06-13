import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lgp_app/services/database.dart';
import '../models/custom_user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

//create user object based on firebase user

  CustomUser? _CreateUser(User? inputUser) {
    return inputUser != null ? CustomUser(uid: inputUser.uid) : null;
  }

  Future<Map<dynamic, dynamic>> get currentUserClaims async {
  final User? user = FirebaseAuth.instance.currentUser;
  // If refresh is set to true, a refresh of the id token is forced.
  final IdTokenResult idTokenResult = await user!.getIdTokenResult(true);
  return idTokenResult.claims!;
}

  Stream<CustomUser?> get inputUser {
    return _auth.authStateChanges().map(_CreateUser);
  }

/*Future getUserType(CustomUser inputUser) async {
var document = await FirebaseFirestore.instance.collection('users').doc(inputUser.uid).get();
return document.data["userType"];
}*/


  //sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _CreateUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
//sign out

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//register with email and password
  Future registerEmailPassword(String email, String password, String userType, String username) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      //create a new document with the user with the uid
      await DatabaseService(uid: user!.uid).updateUserData(name: username, userType: userType);
      return _CreateUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
//sign in with email and password
  Future signInEmailPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _CreateUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

}
