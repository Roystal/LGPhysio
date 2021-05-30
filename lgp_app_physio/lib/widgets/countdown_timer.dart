import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'CircularCountdown.dart';

class BuildCountdown extends StatefulWidget {
  BuildCountdown({Key? key, required this.TimerEnd}) : super(key: key);
  final VoidCallback TimerEnd;
  @override
  _BuildCountdownState createState() => _BuildCountdownState();
}

class _BuildCountdownState extends State<BuildCountdown> {
  CountDownController _controller = CountDownController();

  int _duration = 10;
  bool timerOn = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Column(children: [
          BuildCircularTimer(
              duration: _duration,
              controller: _controller,
              onTimerend: () {
                setState(() {
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
