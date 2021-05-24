import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'main.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Patient workout screen',
      home: OverallScaffold(),
    );
  }
}

class OverallScaffold extends StatefulWidget {
  OverallScaffold({Key key, this.title}) : super(key: key);
  final String title;
  static const routeName = '/second';
  @override
  _OverallScaffoldState createState() => _OverallScaffoldState();
}

class _OverallScaffoldState extends State<OverallScaffold> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as ScreenArguments;

    return Scaffold(
        appBar: AppBar(
          title: Text(args.patientName,
              style: GoogleFonts.roboto(
                  fontSize: 30, fontWeight: FontWeight.bold)),
        ),
        body: MyHomePage(nameOfWorkout: args.exercise));
  }
}

class MyHomePage extends StatefulWidget {
  final String nameOfWorkout;
  const MyHomePage({Key key, this.nameOfWorkout}) : super(key: key);
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
        // countdown
        _buildCountdown(),
        // Reps and Sets
        _buildRepCountContainer(),
        // start / stop button
        _buildStartStopContainer(),
        // return to home page
        _buildReturnButton(),
      ],
    );
  }

  Container _buildImageContainer() {
    return Container(
        margin: const EdgeInsets.all(60.0),
        alignment: Alignment.center,
        child: Image.asset(
          'images/workout_image_1.png',
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

  Container _buildRepCountContainer() {
    return Container(
        margin: const EdgeInsets.only(bottom: 30.0, top: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Reps: 4/8',
                style: GoogleFonts.roboto(
                    fontSize: 20, fontWeight: FontWeight.bold)),
            Text('Sets: 1/3', style: GoogleFonts.roboto(fontSize: 20)),
          ],
        ));
  }

  int _counter = 10 * 1000;
  Timer _timer;
  bool timerOn = false;

  // timer stuff
  void _startTimer() {
    _counter = 10;
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {
        if (_counter > 0) {
          timerOn = true;
          _counter--;
        } else {
          _stopTimer();
        }
      });
    });
  }

  void _stopTimer() {
    setState(() {
      timerOn = false;
      _counter = 10 * 1000;
      _timer.cancel();
    });
  }

  Container _buildStartStopContainer() {
    return Container(
        child: Material(
            child: Transform.scale(
                scale: 4,
                child: IconButton(
                  alignment: Alignment.center,
                  icon: timerOn ? Icon(Icons.pause) : Icon(Icons.play_arrow),
                  color: timerOn ? Colors.red : Colors.green,
                  onPressed: () {
                    setState(() {
                      print('$timerOn');
                      timerOn ? _stopTimer() : _startTimer();
                    });
                  },
                ))));
  }

  Container _buildCountdown() {
    return Container(
        margin: const EdgeInsets.only(bottom: 20.0, top: 20.0),
        child: Text(
            '${Duration(milliseconds: _counter).inMinutes}   :   ${Duration(milliseconds: _counter).inSeconds}    :   $_counter',
            style:
                GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold)));
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
