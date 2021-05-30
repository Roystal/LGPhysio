import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/patient_data.dart';
import '../widgets/BuildAddExercises.dart';
import 'dart:math';

class PatientInfoPage extends StatefulWidget {
  static const routeName = '/second';
  @override
  _PatientInfoPageState createState() => _PatientInfoPageState();
}

class _PatientInfoPageState extends State<PatientInfoPage> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.teal[50],
        appBar: AppBar(
          backgroundColor: Colors.teal[400],
          title: Text(args.patientName,
              style: GoogleFonts.roboto(
                  fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        body: MyHomePage(patientName: args.patientName, size: size));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.patientName, required this.size})
      : super(key: key);
  final String patientName;
  final Size size;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // set state
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Patient image
        _buildImageContainer(widget.size),
        // Next appointment
        _buildNextAppointmentContainer(widget.patientName),

        // Type and duration from injury
        _buildInjuryContainer(widget.size),

        // Add Exercises button
        BuildAddExercises(),
        // return to home page
        _buildReturnButton(),
      ],
    );
  }

  Container _buildImageContainer(Size size) {
    return Container(
        margin: EdgeInsets.all(size.height * 0.05),
        alignment: Alignment.center,
        child: Image.asset(
          'assets/images/patient_img_001.png',
          height: size.height * 0.2,
        ));
  }

  Container _buildNextAppointmentContainer(String patientName) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        'Next Appointment: ${Random().nextInt(30) + 1}/${Random().nextInt(11) + 1}/2021}',
        style: GoogleFonts.roboto(
          fontSize: 20,
        ),
      ),
    );
  }

  // get exercise information from backend

  var _reps = 4;
  Container _buildInjuryContainer(Size size) {
    return Container(
        margin: EdgeInsets.only(top: size.height * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('ACL reconstruction Right Knee, lateral meniscus tear',
                style: GoogleFonts.roboto(
                    fontSize: 20, fontWeight: FontWeight.bold)),
            Text(
              'Week: ${Random().nextInt(30) + 1}',
              style:
                  GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ));
  }

  Container _buildReturnButton() {
    return Container(
        child: Transform.scale(
            scale: 0,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(''),
            )));
  }
}
