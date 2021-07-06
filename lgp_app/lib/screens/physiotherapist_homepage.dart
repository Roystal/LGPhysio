// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:lgp_app/services/auth.dart';
import '../widgets/patientrow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/loading.dart';

class PhysioHome extends StatefulWidget {
  @override
  _PhysioHomeState createState() => _PhysioHomeState();
}

class _PhysioHomeState extends State<PhysioHome> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final AuthService _auth = AuthService();
  @override
  // build function
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        title: Text('Patient List'),
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
          future: FirebaseFirestore.instance
              .collection('users')
              .orderBy('name', descending: true)
              .get(),
          builder: (context, AsyncSnapshot snapshots) {
            if (snapshots.connectionState == ConnectionState.waiting) {
              return Loading();
            } else if (!snapshots.hasData) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/no_patient_found.png",
                      fit: BoxFit.contain,
                      height: size.height * 0.30,
                    ),
                    Text("No patients in the database"),
                  ],
                ),
              );
            } else {
              return RefreshIndicator(
                onRefresh: _refreshData,
                child: ListView.builder(
                    itemCount: snapshots.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot document = snapshots.data!.docs[index];
                      if (document.id == auth.currentUser!.uid ||
                          (document.data() as dynamic)['userType'] ==
                              'Physiotherapist') {
                        return Container(height: 0);
                      }
                      String data =
                          (document.data() as dynamic)['name'].toString();
                      String useruid =
                          (document.data() as dynamic)['useruid'].toString();
                      String appointment =
                          (document.data() as dynamic)['date'].toString();
                      String injuryInput =
                          (document.data() as dynamic)['injury'].toString();

                      return Column(
                        children: [
                          Divider(),
                          Container(
                            child: BuildRow(
                                PatientName: data,
                                useruid: useruid,
                                appointmentDate: appointment,
                                injuryInput: injuryInput),
                          )
                        ],
                      );
                    }),
              );
            }
          }),
    );
  }

  Future getStuff() async {
    var docs;
    await FirebaseFirestore.instance
        .collection('users')
        .orderBy('name', descending: true)
        .get()
        .then((querySnapshot) {
      docs = querySnapshot;
    });
    return docs;
  }

  Future _refreshData() async {
    await getStuff();
    setState(() {});
  }
}
