// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:homepage_and_exercise/exercisepage.dart';
import 'main.dart';
import 'dart:math';

class ExerciseListPage extends StatefulWidget {
  static const routeName = '/';
  @override
  _ExerciseListPageState createState() => _ExerciseListPageState();
}

class _ExerciseListPageState extends State<ExerciseListPage> {
  final _biggerFont = TextStyle(fontSize: 18.0);
  @override

  // build function
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        backgroundColor: Colors.teal[400],
        /*
        leading: IconButton(
          icon: Icon(Icons.album, color: Colors.teal[500]),
          onPressed: null,
        ),
        */
        title: Text('Exercise List'),
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

          return _buildRow(_getNameOfWorkout(), index);
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

  // build row function
  Widget _buildRow(String exercise, int index) {
    return ListTile(
      onTap: () {
        print('Item $exercise was tapped!');
        Navigator.pushNamed(context, ExercisePage.routeName,
            arguments: ScreenArguments('Sample Patient Name', exercise));
      },
      leading: Icon(Icons.album, color: Colors.teal[800]),
      title: Text(
        exercise,
        style: _biggerFont,
      ),
      subtitle: Text(
          'Reps: ${Random().nextInt(10) + 5}, Sets: ${Random().nextInt(4) + 1}'),
    );
  }
}
