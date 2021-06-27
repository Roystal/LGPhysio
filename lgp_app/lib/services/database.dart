import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/exercises.dart';

class DatabaseService {
  final String uid;
  String name = "";
  String userType = "";
  List<dynamic> exercises = [];
  String useruid = "";

  DatabaseService({required this.uid});

  //collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future updateUserData(
      {required String name, required String userType, required String useruid}) async {
    return await userCollection.doc(uid).set({
      'userType': userType,
      'name': name,
      'useruid': useruid,
      'exercises': this.exercises,
    });
  }

  // get user stream
  Stream<QuerySnapshot> get users {
    return userCollection.snapshots();
  }

  DatabaseService.fromMap(Map<dynamic, dynamic> map)
      : name = map['name'],
        uid = map['uid'],
        userType = map['userType'],
        exercises = map['exercises'].map((set) {
          return Exercise.fromMap(set);
        }).toList();
}
