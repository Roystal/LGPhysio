import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

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
  //final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
  @override
  _OverallScaffoldState createState() => _OverallScaffoldState();
}

class _OverallScaffoldState extends State<OverallScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Name of patient',
            style: GoogleFonts.getFont('Roboto'),
          ),
        ),
        body: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
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
        _buildNameOfWorkoutContainer(),
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

  Container _buildNameOfWorkoutContainer() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        'Name of workout',
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

  Container _buildStartStopContainer() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0, top: 20.0),
      child: ButtonWidget(),
    );
  }

  Container _buildCountdown() {
    return Container(child: Text('$timerCount'));
  }

  Container _buildReturnButton() {
    return Container(
        child: ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text(''),
    ));
  }
}

bool timerOn = false;
int timerCount = 10;

// Button Widget for starting ending and pausing timer
class ButtonWidget extends StatefulWidget {
  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Transform.scale(
            scale: 4,
            child: IconButton(
              alignment: Alignment.center,
              icon: timerOn ? Icon(Icons.pause) : Icon(Icons.play_arrow),
              color: timerOn ? Colors.red : Colors.green,
              onPressed: () {
                print('$timerOn');
                timerOn ? stopTimer() : startTimer();
              },
            )));
  }

/*
  void _toggleisStarted() {
    setState(() {
      if (timerOn) {
        timerOn = false;
        startTimeout.cancel();
      } else {
        startTimer();
      }
    });
  }
*/
  // timer functions

  Timer _timer;

  void startTimer() {
    timerCount = 10;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (timerCount == 0) {
          timerOn = false;
          setState(() {
            timer.cancel();
          });
        } else {
          timerOn = true;
          setState(() {
            timerCount--;
          });
        }
      },
    );
  }

  void stopTimer() {
    _timer.cancel();
    timerOn = false;
    timerCount = 10;
  }
}
