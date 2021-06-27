import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/exercises.dart';

class DatabaseService {
  final String uid;
  String name = "";
  String userType = "";
  List<dynamic> exercises = [];
  String useruid = "";
  String date = "";

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
      'date' : "Not Confirmed",
    });
  }

  // get user stream
  Stream<QuerySnapshot> get users {
    return userCollection.snapshots();
  }
}
