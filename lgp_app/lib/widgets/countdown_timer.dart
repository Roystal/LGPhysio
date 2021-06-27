import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'CircularCountdown.dart';
import '../models/exercises.dart';

class BuildCountdown extends StatefulWidget {
  BuildCountdown(
      {required this.nameOfWorkout,
      required this.patientName,
      required this.size,
      required this.exercise});
  final String nameOfWorkout;
  final String patientName;
  final Size size;
  final Exercise exercise;
  @override
  _BuildCountdownState createState() => _BuildCountdownState();
}

class _BuildCountdownState extends State<BuildCountdown> {
  CountDownController _controller = CountDownController();

  int _duration = 10;
  bool timerOn = false;
  int _reps = 0;
  int _sets = 0;
  @override
  Widget build(BuildContext context) {
    _reps = int.parse(widget.exercise.reps);
    _sets = int.parse(widget.exercise.sets);
    return Container(
        margin: EdgeInsets.only(top: widget.size.height * 0.05),
        alignment: Alignment.center,
        child: Column(children: [
          Text('Reps: $_reps/$_reps', style: TextStyle(fontSize: 20)),
          Text(
            'Sets: $_sets/$_sets',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          BuildCircularTimer(
              duration: _duration,
              controller: _controller,
              onTimerend: () {
                setState(() {
                  _reps -= 1;
                  timerOn = false;
                  _controller.start();
                  _controller.pause();
                });
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 30,
              ),
              _button(
                  title: timerOn ? "Stop" : "Start",
                  timerOn: timerOn,
                  onPressed: () {
                    setState(() {
                      if (timerOn) {
                        _controller.start();
                        _controller.pause();
                        timerOn = false;
                      } else {
                        _controller.start();
                        timerOn = true;
                      }
                    });
                  }),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ]));
  }
}

_button(
    {required String title, required bool timerOn, VoidCallback? onPressed}) {
  return Container(
      margin: const EdgeInsets.only(right: 14),
      alignment: Alignment.center,
      child: Transform.scale(
          scale: 3,
          child: IconButton(
            icon: timerOn ? Icon(Icons.stop) : Icon(Icons.play_arrow),
            color: timerOn ? Colors.red[400] : Colors.tealAccent[700],
            onPressed: onPressed,
          )));
}
