// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'PatientInfoPage.dart';
import 'package:lgp_app/services/auth.dart';
import '../models/patient_data.dart';
import 'dart:math';

class Home extends StatefulWidget {
  //static const routeName = "/";
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  final _biggerFont = TextStyle(fontSize: 18.0);
  @override
  // build function
  Widget build(BuildContext context) {
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
      body: _buildSuggestions(),
    );
  }

  // build suggestions function
  Widget _buildSuggestions() {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/

          return _buildRow(_getPatientName(), index);
        });
  }

  String _getPatientName() {
    var sampleNames = [
      'Titus Ng',
      'Roy Chua',
      'Thomas Young',
      'Tan Jing Heng',
      'Lim Zhi Xiong',
      'Bob Christenson',
      'William Edison',
    ];
    return sampleNames[Random().nextInt(sampleNames.length)];
  }

  // build row function
  Widget _buildRow(String patientName, int index) {
    return ListTile(
      onTap: () {
        print('Item $patientName was tapped!');
        Navigator.pushNamed(this.context, PatientInfoPage.routeName,
            arguments: ScreenArguments('Sample Patient Name'));
      },
      leading: Icon(Icons.album, color: Colors.teal[800]),
      title: Text(
        patientName,
        style: _biggerFont,
      ),
      subtitle: Text(
          'Next Appointment: ${Random().nextInt(30) + 1}/${Random().nextInt(11) + 1}/2021}'),
    );
  }
}
