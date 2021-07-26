import 'package:lgp_app/screens/deleteeditexercise.dart';
import '../models/screen_data.dart';
import 'package:flutter/material.dart';
import '../models/exercises.dart';

class EditExerciseRow extends StatelessWidget {
  final Exercise exercise;
  final String userid;
  EditExerciseRow({required this.exercise, required this.userid});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        print('Item $exercise was tapped!');
        Navigator.pushNamed(context, EditableExercise.routeName,
            arguments: ScreenArguments("dummy", exercise, this.userid, "dummy", "dummy"));
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