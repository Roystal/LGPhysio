import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Patient workout screen',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: OverallScaffold(),
    );
  }
}

class OverallScaffold extends StatefulWidget {
  OverallScaffold({Key key, this.title}) : super(key: key);
  final String title;
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
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
      ],
    );
  }

  Container _buildImageContainer() {
    return Container(
        margin: const EdgeInsets.all(60.0),
        alignment: Alignment.center,
        child: Expanded(
          child: Image.asset(
            'images/workout_image_1.jpeg',
          ),
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
