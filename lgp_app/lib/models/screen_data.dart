import '../models/exercises.dart';

class ScreenArguments {
  final String patientName;
  final Exercise exercise;
  final String useruid;
  final String appointmentDate;
  final String injuryInput;
  ScreenArguments(this.patientName, this.exercise, this.useruid, this.appointmentDate, this.injuryInput);
}
