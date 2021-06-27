import '../screens/exercisepage.dart';
import '../models/screen_data.dart';
import 'package:flutter/material.dart';
import '../models/exercises.dart';
import 'package:provider/provider.dart';
import 'package:lgp_app/models/custom_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BuildExerciseRow extends StatelessWidget {
  final Exercise exercise;
  final String userid;
  BuildExerciseRow({required this.exercise, required this.userid});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        print('Item $exercise was tapped!');
        Navigator.pushNamed(context, ExercisePage.routeName,
            arguments: ScreenArguments("dummy", exercise.exercise, this.userid));
      },
      leading: Icon(Icons.album, color: Colors.teal[800]),
      title: Text(
        exercise.exercise,
      ),
      subtitle: Text(
          'Reps: ${exercise.reps}, Sets: ${exercise.sets}'),
    );
  }
}
