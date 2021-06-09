import 'package:flutter/material.dart';
import '../models/patient_data.dart';
import '../widgets/countdown_timer.dart';

class ExercisePage extends StatefulWidget {
  static const routeName = '/second';
  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.teal[50],
        appBar: AppBar(
          backgroundColor: Colors.teal[400],
          title: Text(args.patientName,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        body: MyHomePage(
            nameOfWorkout: args.exercise,
            patientName: args.patientName,
            size: size));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {Key? key,
      required this.nameOfWorkout,
      required this.patientName,
      required this.size})
      : super(key: key);
  final String nameOfWorkout;
  final String patientName;
  final Size size;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // set state
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // workout image
        _buildImageContainer(widget.size),
        // name of workout
        _buildNameOfWorkoutContainer(widget.nameOfWorkout),

        BuildCountdown(
            size: widget.size,
            patientName: widget.patientName,
            nameOfWorkout: widget.nameOfWorkout),
        // return to home page
        _buildReturnButton(),
      ],
    );
  }

  Container _buildImageContainer(Size size) {
    return Container(
        margin: EdgeInsets.all(size.height * 0.05),
        alignment: Alignment.center,
        child: Image.asset(
          'assets/images/workout_image_1.png',
          height: size.height * 0.2,
        ));
  }

  Container _buildNameOfWorkoutContainer(String nameOfWorkout) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        nameOfWorkout,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Container _buildReturnButton() {
    return Container(
        child: Transform.scale(
            scale: 0,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(''),
            )));
  }
}
