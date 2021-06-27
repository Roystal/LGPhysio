// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:lgp_app/services/auth.dart';
import '../widgets/rounded_input_field.dart';
import '../widgets/rounded_input_number_field.dart';
import '../widgets/rounded_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/exercises.dart';
import 'package:provider/provider.dart';
import 'package:lgp_app/models/custom_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/exerciserow.dart';

class PatientHome extends StatefulWidget {
  @override
  _PatientHomeState createState() => _PatientHomeState();
}

class _PatientHomeState extends State<PatientHome> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final AuthService _auth = AuthService();
  final _biggerFont = TextStyle(fontSize: 18.0);
  @override
  // build function
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        title: Text('Exercise List'),
        backgroundColor: Colors.teal[400],
        actions: [
          Column(
            children: [
              TextButton.icon(
                onPressed: () async {
                  dynamic result = await _auth.signOut();
                  if (result == null) {
                    print('signed out');
                  } else {
                    print('error signing out');
                  }
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.teal,
                ),
                label: Text(
                  'Logout',
                  style: TextStyle(color: Colors.teal),
                ),
                style: TextButton.styleFrom(
                  onSurface: Colors.white,
                  backgroundColor: Colors.white,
                  shape: const BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                ),
              ),
            ],
          ),
        ],
        /*
        leading: IconButton(
          icon: Icon(Icons.album, color: Colors.teal[500]),
          onPressed: null,
        ),
        */
      ),
      body: FutureBuilder<dynamic>(
          future: getStuff(user!.uid),
          builder: (context, AsyncSnapshot snapshots) {
            if (snapshots.hasData) {
              return ListView.builder(
                  itemCount:
                      (snapshots.data! as dynamic).data()["exercises"].length,
                  itemBuilder: (context, index) {
                    Exercise exercising;
                    exercising = Exercise.fromMap((snapshots.data as dynamic).data()["exercises"][index]);
                    print(exercising.exercise);
                    return Column(
                      children: [
                        Divider(),
                        Container(
                          child: BuildExerciseRow(
                              exercise: exercising, userid: user.uid),
                        )
                      ],
                    );
                  });
             }
             else { return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/no_patient_found.png",
                      fit: BoxFit.contain,
                      height: size.height * 0.30,
                    ),
                    Text("No exercises in the database"),
                  ],
                ),
              );
            } 
          }),
    );
  }

  Future getStuff(String useruid) async {
  var docs;
  await FirebaseFirestore.instance
              .collection("users")
              .doc(useruid)
              .get()
      .then((querySnapshot) {
    docs = querySnapshot;
  });
  return docs;
}

  Future getStuffAgain(snapshots, index) async {
  var docs;
  await Exercise.fromMap((snapshots.data as dynamic).data()["exercises"][index]);
  return docs;
}

  Future<List<dynamic>> getList(String useruid) async {
    var firestore = FirebaseFirestore.instance;

    DocumentReference docRef = firestore.collection('users').doc(useruid);

    return docRef.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        List<Exercise> info =
            (datasnapshot.data() as dynamic)['exercises'].toList();
        print(info);
        return info;
      }
      return List.filled(0, null);
    });
  }
}
