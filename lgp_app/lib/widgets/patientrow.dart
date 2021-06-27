import '../screens/PatientInfoPage.dart';
import '../models/screen_data.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import '../models/exercises.dart';

class BuildRow extends StatelessWidget {
  final PatientName;
  final useruid;
  BuildRow({required this.PatientName, required this.useruid});
  @override
  Widget build(BuildContext context) {
    Exercise exercising = Exercise("dummy", "dummy", "dummy");
    return ListTile(
      onTap: () {
        print('Item $PatientName was tapped!');
        Navigator.pushNamed(context, PatientInfoPage.routeName,
            arguments: ScreenArguments(PatientName, exercising ,useruid));
      },
      leading: Icon(Icons.album, color: Colors.teal[800]),
      title: Text(
        PatientName,
      ),
      subtitle: Text(
          'Reps: ${Random().nextInt(10) + 5}, Sets: ${Random().nextInt(4) + 1}'),
    );
  }
}
