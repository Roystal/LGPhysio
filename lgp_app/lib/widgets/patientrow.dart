import '../screens/PatientInfoPage.dart';
import '../models/screen_data.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import '../models/exercises.dart';

class BuildRow extends StatelessWidget {
  final PatientName;
  final useruid;
  final appointmentDate;
  final injuryInput;
  BuildRow({required this.PatientName, required this.useruid, required this.appointmentDate, required this.injuryInput});
  @override
  Widget build(BuildContext context) {
    Exercise exercising = Exercise("dummy", "dummy", "dummy", "dummy");
    return ListTile(
      onTap: () {
        print('Item $PatientName was tapped!');
        Navigator.pushNamed(context, PatientInfoPage.routeName,
            arguments: ScreenArguments(PatientName, exercising ,useruid, appointmentDate, injuryInput));
      },
      leading: Icon(Icons.album, color: Colors.teal[800]),
      title: Text(
        PatientName,
      ),
      subtitle: Text(
          'Next Appointment Date: $appointmentDate'),
    );
  }
}
