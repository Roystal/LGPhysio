import '../models/exercises.dart';

class ScreenArguments {
  final String patientName;
  final Exercise exercise;
  final String useruid;
  final String appointmentDate;
  ScreenArguments(this.patientName, this.exercise, this.useruid, this.appointmentDate);
}
