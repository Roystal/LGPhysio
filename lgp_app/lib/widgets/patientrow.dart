import '../screens/PatientInfoPage.dart';
import '../models/patient_data.dart';
import 'dart:math';
import 'package:flutter/material.dart';

class BuildRow extends StatelessWidget {
  final PatientName;
  BuildRow({required this.PatientName});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        print('Item $PatientName was tapped!');
        Navigator.pushNamed(context, PatientInfoPage.routeName,
            arguments: PhysioScreenArguments(PatientName));
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
