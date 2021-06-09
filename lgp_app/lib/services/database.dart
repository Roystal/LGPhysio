import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
final String uid;

DatabaseService({required this.uid});

  //collection reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  Future updateUserData({required String name, required String userType}) async {
    return await userCollection.doc(uid).set({
      'userType' : userType,
      'name' : name,
    });
  }

  // get user stream
  Stream<QuerySnapshot> get users {
    return userCollection.snapshots();
  }

}