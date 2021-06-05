// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import '../screens/exercisepage.dart';
import 'package:lgp_app/services/auth.dart';
import '../models/patient_data.dart';
import 'dart:math';
import '../widgets/exerciserow.dart';

class Home extends StatefulWidget {
  //static const routeName = "/";
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
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
          return buildRow(exercise: _getNameOfWorkout());
        });
  }

  String _getNameOfWorkout() {
    var sampleExercises = [
      'Hamstring Stretch',
      'Calf Stretch',
      'Knee extension',
      'Calf raises',
      'Quad Stretch',
      'Single leg Bulgarian Squat',
      'Double leg Squat',
      'Lunges (both legs)',
      'Double leg box jumps (20cm)',
      'Single leg Bridging',
      'Single leg Hamstring Curl',
      'Single leg Leg Press',
      'Bending Stretch (90 degrees)'
    ];
    return sampleExercises[Random().nextInt(sampleExercises.length)];
  }
}
