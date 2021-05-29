import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/patient_data.dart';
import '../widgets/countdown_timer.dart';

class OverallScaffold extends StatefulWidget {
  static const routeName = '/second';
  @override
  _OverallScaffoldState createState() => _OverallScaffoldState();
}

class _OverallScaffoldState extends State<OverallScaffold> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return Scaffold(
        backgroundColor: Colors.teal[50],
        appBar: AppBar(
          backgroundColor: Colors.teal[400],
          title: Text(args.patientName,
              style: GoogleFonts.roboto(
                  fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        body: MyHomePage(nameOfWorkout: args.exercise));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.nameOfWorkout}) : super(key: key);
  final String nameOfWorkout;
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
        _buildImageContainer(),
        // name of workout
        _buildNameOfWorkoutContainer(widget.nameOfWorkout),

        // Reps and Sets
        _buildRepCountContainer(),

        BuildCountdown(
          TimerEnd: () {
            print('Timer end');
          },
        ),
        // return to home page
        _buildReturnButton(),
      ],
    );
  }

  Container _buildImageContainer() {
    Size size = MediaQuery.of(context).size;
    return Container(
        margin: const EdgeInsets.all(40.0),
        alignment: Alignment.center,
        child: Image.asset(
          'assets/images/workout_image_1.png',
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
  Container _buildRepCountContainer() {
    return Container(
        margin: const EdgeInsets.only(bottom: 0, top: 30.0),
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
