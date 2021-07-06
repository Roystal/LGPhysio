class Exercise {
  final String exercise;
  final String sets;
  final String reps;
  final String type;

  Exercise(this.exercise, this.sets, this.reps, this.type);

  Map<String,dynamic> toMap() => {
    "exercise": this.exercise,
    "sets": this.sets,
    "reps": this.reps,
    "type": this.type,
  };

   Exercise.fromMap(Map<dynamic, dynamic> map)
      : sets = map["sets"].toString(),
      exercise = map["exercise"],
        reps = map["reps"].toString(),
        type = map["type"].toString();
}