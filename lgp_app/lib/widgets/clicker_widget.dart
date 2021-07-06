import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'CircularCountdown.dart';
import '../models/exercises.dart';
import 'package:provider/provider.dart';
import 'package:lgp_app/models/custom_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'rounded_button.dart';

class Clicker extends StatefulWidget {
  const Clicker(
      {required this.nameOfWorkout,
      required this.patientName,
      required this.size,
      required this.exercise});

  final String nameOfWorkout;
  final String patientName;
  final Size size;
  final Exercise exercise;

  @override
  _ClickerState createState() => _ClickerState();
}

class _ClickerState extends State<Clicker> {
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
        Text('Sets: $_sets/$initialsets',
            style: TextStyle(
              fontSize: 20,
            )),
            SizedBox(height: 30,),
        RoundedButton(
            text: "1 REP COMPLETED",
            press: () {
              setState(() {
                if (_reps == 1 && _sets > 1) {
                  _reps = initialreps;
                  _sets -= 1;
                } else if (_reps > 1 && _sets >= 1) {
                  _reps -= 1;
                } else {
                  _reps = initialreps;
                  _sets = initialsets;
                }
                /*FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(user!.uid)
                                  .update({
                                "exercises":
                                    injury,
                              });*/
              });
            })
      ]),
    );
  }
}
