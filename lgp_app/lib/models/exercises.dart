class Exercise {
  final String exercise;
  final String sets;
  final String reps;

  Exercise(this.exercise, this.sets, this.reps);

  Map<String,dynamic> toMap() => {
    "exercise": this.exercise,
    "sets": this.sets,
    "reps": this.reps
  };

   Exercise.fromMap(Map<dynamic, dynamic> map)
      : sets = map["sets"].toString(),
      exercise = map["exercise"],
        reps = map["reps"].toString();
}