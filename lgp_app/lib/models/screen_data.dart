import '../models/exercises.dart';

class ScreenArguments {
  final String patientName;
  final Exercise exercise;
  final String useruid;
  ScreenArguments(this.patientName, this.exercise, this.useruid);
}
