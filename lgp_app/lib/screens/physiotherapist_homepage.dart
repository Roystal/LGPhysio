// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:lgp_app/services/auth.dart';
import '../widgets/patientrow.dart';

class PhysioHome extends StatefulWidget {
  //static const routeName = "/";
  @override
  _PhysioHomeState createState() => _PhysioHomeState();
}

class _PhysioHomeState extends State<PhysioHome> {
  final AuthService _auth = AuthService();
  final _biggerFont = TextStyle(fontSize: 18.0);
  @override
  // build function
  Widget build(BuildContext context) {
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
        /*
        leading: IconButton(
          icon: Icon(Icons.album, color: Colors.teal[500]),
          onPressed: null,
        ),
        */
      ),
      body: _buildSuggestions(),
    );
  }

  // build suggestions function
  Widget _buildSuggestions() {
    const int noOfPatients = 24; // get from firebase
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: noOfPatients * 2,
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/

          return BuildRow(PatientName: _getPatientName(index));
        });
  }

  String _getPatientName(int index) {
    var sampleNames = [
      'Titus Ng',
      'Roy Chua',
      'Thomas Young',
      'Tan Jing Heng',
      'Lim Zhi Xiong',
      'Bob Christenson',
      'William Edison',
      'Joy Serena',
      'Dick Stacy',
      'Yong Quan Tan',
      'Chong Yu Le',
      'Max Lee',
      'Tan Kah Kee',
      'Tan Tock Seng',
      'Taylor Musk',
      'Elon Swift',
      'Fernando Muchi',
      'Felix Pietro',
      'Monza Costa',
      'Chan Da Xiong',
      'Lee Jun Er',
      'Tamie Ng',
      'Jaymes May',
      'Jeremy Williamson'
    ];
    return sampleNames[index];
  }
}
