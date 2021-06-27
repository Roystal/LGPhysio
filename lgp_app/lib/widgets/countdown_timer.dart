import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'CircularCountdown.dart';
import '../models/exercises.dart';
import 'package:provider/provider.dart';
import 'package:lgp_app/models/custom_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  int initialreps = 0;
  int initialsets = 0;
  @override
  void initState() {
    super.initState();
    initialreps = int.parse(widget.exercise.reps);
    initialsets = int.parse(widget.exercise.sets);
    _reps = int.parse(widget.exercise.reps);
    _sets = int.parse(widget.exercise.sets);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    return Container(
        margin: EdgeInsets.only(top: widget.size.height * 0.05),
        alignment: Alignment.center,
        child: Column(children: [
          Text('Reps: $_reps/$initialreps', style: TextStyle(fontSize: 20)),
          Text(
            'Sets: $_sets/$initialsets',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          BuildCircularTimer(
              duration: _duration,
              controller: _controller,
              onTimerend: () {
                setState(() {
                  if (_reps == 1 && _sets > 1) {
                    _reps = initialreps;
                    _sets -= 1;
                    timerOn = false;
                    _controller.start();
                    _controller.pause();
                  } else if (_reps > 1 && _sets >= 1) {
                    _reps -= 1;
                    timerOn = false;
                    _controller.start();
                    _controller.pause();
                  } else {
                    _reps = initialreps;
                    _sets = initialsets;
                    timerOn = false;
                    _controller.start();
                    _controller.pause();
                  }
                   /*FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(user!.uid)
                                  .update({
                                "exercises":
                                    injury,
                              });*/
                }
                );
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
