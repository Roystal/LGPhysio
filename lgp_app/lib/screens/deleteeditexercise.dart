import 'package:flutter/material.dart';
import 'package:lgp_app/widgets/DeleteExercise.dart';
import 'package:lgp_app/widgets/EditExercise.dart';
import '../models/screen_data.dart';
import '../models/exercises.dart';

class EditableExercise extends StatefulWidget {
  static const routeName = 'EditableExercise';
  @override
  _EditableExerciseState createState() => _EditableExerciseState();
}

class _EditableExerciseState extends State<EditableExercise> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.teal[50],
        appBar: AppBar(
          backgroundColor: Colors.teal[400],
          title: Text("Edit ${args.exercise.exercise}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        body: MyHomePage(
            nameOfWorkout: args.exercise.exercise,
            patientName: args.patientName,
            size: size,
            exercise: args.exercise,
            useruid: args.useruid,));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {Key? key,
      required this.useruid,
      required this.exercise,
      required this.nameOfWorkout,
      required this.patientName,
      required this.size})
      : super(key: key);
  final String useruid;
  final String nameOfWorkout;
  final String patientName;
  final Size size;
  final Exercise exercise;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // set state
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DeleteExercise(
            nameofworkout: widget.nameOfWorkout, useruid: widget.useruid, exercise: widget.exercise
          ),
          SizedBox(height: 3,),
          EditExercise(
            nameofworkout: widget.nameOfWorkout, useruid: widget.useruid, exercise: widget.exercise
          )
        ],
      ),
    );
  }
}
