import '../screens/exercisepage.dart';
import 'package:lgp_app/services/auth.dart';
import '../models/patient_data.dart';
import 'dart:math';
import 'package:flutter/material.dart';

class BuildRow extends StatelessWidget {
  final exercise;
  BuildRow({required this.exercise});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        print('Item $exercise was tapped!');
        Navigator.pushNamed(context, ExercisePage.routeName,
            arguments: ScreenArguments('Sample Patient Name', exercise));
      },
      leading: Icon(Icons.album, color: Colors.teal[800]),
      title: Text(
        exercise,
      ),
      subtitle: Text(
          'Reps: ${Random().nextInt(10) + 5}, Sets: ${Random().nextInt(4) + 1}'),
    );
  }
}
