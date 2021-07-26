import 'package:flutter/material.dart';
import 'package:lgp_app/widgets/UpdateExercises.dart';
import 'package:lgp_app/widgets/rounded_button.dart';
import '../models/screen_data.dart';
import '../widgets/BuildAddExercises.dart';
import 'dart:math';
import '../widgets/UpdateNextAppointment.dart';
import '../widgets/UpdateInjury.dart';

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
          title: Text(
            args.patientName,
          ),
        ),
        body: SingleChildScrollView(
          child: MyHomePage(
              patientName: args.patientName,
              size: size,
              useruid: args.useruid,
              appointmentDate: args.appointmentDate,
              injuryInput: args.injuryInput),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {Key? key,
      required this.patientName,
      required this.size,
      required this.useruid,
      required this.appointmentDate,
      required this.injuryInput})
      : super(key: key);
  final String patientName;
  final Size size;
  final String useruid;
  final String appointmentDate;
  final String injuryInput;
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
        _buildNextAppointmentContainer(widget.appointmentDate),

        // Type and duration from injury
        _buildInjuryContainer(widget.size, widget.injuryInput),

        // Add Exercises button
        BuildAddExercises(useruid: widget.useruid),

        SizedBox(
          height: 20,
        ),

        // Update Appointment Date button
        UpdateAppointment(useruid: widget.useruid),

        SizedBox(
          height: 20,
        ),

        // Update Injury button
        UpdateInjury(useruid: widget.useruid),

        SizedBox(
          height: 20,
        ),

        UpdateExercises(widget.useruid),

        // return to home page
        _buildReturnButton(),
      ],
    );
  }

  Widget UpdateExercises(String useruid) {
    return RoundedButton(
        text: "View/Edit Patient's Exercises",
        press: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditPatient(useruid: useruid)));
        });
  }

  Container _buildImageContainer(Size size) {
    return Container(
        margin: EdgeInsets.all(size.height * 0.05),
        alignment: Alignment.center,
        child: Image.asset(
          'assets/images/patient_img_002.png',
          height: size.height * 0.2,
        ));
  }

  Container _buildNextAppointmentContainer(String appointmentDate) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        'Next Appointment: $appointmentDate',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  // get injury information from backend
  Container _buildInjuryContainer(Size size, String injury) {
    return Container(
        margin: EdgeInsets.only(
            top: size.height * 0.05, bottom: size.height * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(
                  right: size.width * 0.05,
                  left: size.width * 0.10,
                  bottom: size.height * 0.04),
              child: Text(
                injury.toString(),
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
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
