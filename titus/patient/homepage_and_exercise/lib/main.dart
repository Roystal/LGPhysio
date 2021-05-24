import 'package:flutter/material.dart';
import 'package:homepage_and_exercise/exercisepage.dart';
import 'homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nav screens',

      // Routes
      initialRoute: '/',
      routes: {
        '/': (context) => RandomWords(),
        '/second': (context) => OverallScaffold(),
      },
    );
  }
}

class ScreenArguments {
  final String patientName;
  final String exercise;
  ScreenArguments(this.patientName, this.exercise);
}
