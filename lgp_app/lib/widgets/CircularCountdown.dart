import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class BuildCircularTimer extends StatelessWidget {
  BuildCircularTimer({
    Key? key,
    required int duration,
    required CountDownController controller,
    required this.onTimerend,
  })  : _duration = duration,
        _controller = controller,
        super(key: key);

  final int _duration;
  final CountDownController _controller;
  final VoidCallback onTimerend;

  @override
  Widget build(BuildContext context) {
    return CircularCountDownTimer(
      // Countdown duration in Seconds.
      duration: _duration,

      // Countdown initial elapsed Duration in Seconds.
      initialDuration: 0,

      // Controls (i.e Start, Pause, Resume, Restart) the Countdown Timer.
      controller: _controller,

      // Width of the Countdown Widget.
      // width: 0,
      width: MediaQuery.of(context).size.width / 4,

      // Height of the Countdown Widget.
      // height: 0,
      height: MediaQuery.of(context).size.height / 4,

      // Ring Color for Countdown Widget.
      ringColor: Colors.grey[300]!,

      // Ring Gradient for Countdown Widget.
      ringGradient: null,
      //RadialGradient(colors: [Colors.teal, Colors.white]),

      // Filling Color for Countdown Widget.
      fillColor: Colors.teal[500]!,

      // Filling Gradient for Countdown Widget.
      fillGradient: null,

      // Background Color for Countdown Widget.
      backgroundColor: Colors.teal[300],

      // Background Gradient for Countdown Widget.
      backgroundGradient: null,

      // Border Thickness of the Countdown Ring.
      strokeWidth: 15.0,

      // Begin and end contours with a flat edge and no extension.
      strokeCap: StrokeCap.round,

      // Text Style for Countdown Text.
      textStyle: TextStyle(
          fontSize: 33.0, color: Colors.white, fontWeight: FontWeight.bold),

      // Format for the Countdown Text.
      textFormat: CountdownTextFormat.S,

      // Handles Countdown Timer (true for Reverse Countdown (max to 0), false for Forward Countdown (0 to max)).
      isReverse: true,

      // Handles Animation Direction (true for Reverse Animation, false for Forward Animation).
      isReverseAnimation: false,

      // Handles visibility of the Countdown Text.
      isTimerTextShown: true,

      // Handles the timer start.
      autoStart: false,

      // This Callback will execute when the Countdown Starts.
      onStart: () {
        // Here, do whatever you want
        //print('Countdown Started');
      },

      // This Callback will execute when the Countdown Ends.
      onComplete: () {
        // Here, do whatever you want
        onTimerend();
      },
    );
  }
}
