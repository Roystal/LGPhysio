// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:lgp_app/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lgp_app/screens/MainDrawer.dart';
import '../models/exercises.dart';
import 'package:provider/provider.dart';
import 'package:lgp_app/models/custom_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/exerciserow.dart';
import '../widgets/loading.dart';

class PatientHome extends StatefulWidget {
  @override
  _PatientHomeState createState() => _PatientHomeState();
}

class _PatientHomeState extends State<PatientHome> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final AuthService _auth = AuthService();
  @override
  // build function
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: MainDrawer(),
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
      ),
      body: FutureBuilder(
          future: getStuff(user!.uid),
          builder: (context, AsyncSnapshot snapshots) {
            if (snapshots.data != null) {
              String AppointmentDate =
                  (snapshots.data as dynamic).data()["date"].toString();
              String InjuryType =
                  (snapshots.data as dynamic).data()["injury"].toString();
              if (snapshots.connectionState != ConnectionState.done) {
                return Loading();
              } else if (!snapshots.hasData) {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if ((snapshots.data! as dynamic)
                      .data()["exercises"]
                      .length ==
                  0) {
                return Center(
                  child: Column(
                    children: [
                      TopContainer(AppointmentDate, InjuryType),
                      Container(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/no_patient_found.png",
                            fit: BoxFit.contain,
                            height: size.height * 0.30,
                          ),
                          Text("No exercises in the database"),
                        ],
                      )),
                    ],
                  ),
                );
              } else {
                return RefreshIndicator(
                  onRefresh: () => _refreshData(user.uid),
                  child: Column(mainAxisSize: MainAxisSize.max, children: [
                    Column(
                      children: [
                        TopContainer(AppointmentDate, InjuryType),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          itemCount: (snapshots.data! as dynamic)
                              .data()["exercises"]
                              .length,
                          itemBuilder: (context, index) {
                            Exercise exercising;
                            exercising = Exercise.fromMap(
                                (snapshots.data as dynamic).data()["exercises"]
                                    [index]);
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
                          }),
                    ),
                  ]),
                );
              }
            } else {
              return CircularProgressIndicator();
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

  Future _refreshData(String useruid) async {
    await getStuff(useruid);
    setState(() {});
  }

  Widget TopContainer(String AppointmentDate, String InjuryType) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.teal, width: 2.0)),
      child: Column(
        children: [
          Text(
            "Next Appointment Date: $AppointmentDate",
            style:
                TextStyle(fontFamily: "Circular", fontWeight: FontWeight.bold),
          ),
          Text(
            "Injury: $InjuryType",
            style:
                TextStyle(fontFamily: "Circular", fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
