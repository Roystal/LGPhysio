import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main.dart';
import 'countdown_timer.dart';

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
              style: GoogleFonts.roboto(
                  fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        body: MyHomePage(nameOfWorkout: args.exercise, size: size));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.nameOfWorkout, required this.size})
      : super(key: key);
  final String nameOfWorkout;
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

        // Reps and Sets
        _buildRepCountContainer(widget.size),

        BuildCountdown(
          onTimerEnd: () {
            print('Timer end');
          },
          duration: 10,
        ),
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
          'images/workout_image_1.png',
          height: size.height * 0.2,
        ));
  }

  Container _buildNameOfWorkoutContainer(String nameOfWorkout) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        nameOfWorkout,
        style: GoogleFonts.roboto(
          fontSize: 20,
        ),
      ),
    );
  }

  // get exercise information from backend

  var _reps = 4;
  Container _buildRepCountContainer(Size size) {
    return Container(
        margin: EdgeInsets.only(top: size.height * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Reps: 4/8',
                style: GoogleFonts.roboto(
                    fontSize: 20, fontWeight: FontWeight.bold)),
            Text(
              'Sets: 1/3',
              style:
                  GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ));
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
