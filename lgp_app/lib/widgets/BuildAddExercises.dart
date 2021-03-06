import 'package:flutter/material.dart';
import 'package:lgp_app/widgets/rounded_button.dart';
import '../widgets/rounded_input_field.dart';
import '../widgets/rounded_input_number_field.dart';
import '../widgets/rounded_button.dart';
import '../models/exercises.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/text_field_container.dart';

class BuildAddExercises extends StatefulWidget {
  final String useruid;
  const BuildAddExercises({Key? key, required this.useruid}) : super(key: key);
  @override
  _BuildAddExercisesState createState() => _BuildAddExercisesState();
}

class _BuildAddExercisesState extends State<BuildAddExercises> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        child: RoundedButton(
            text: 'Add exercise',
            press: () {
              String sets = '';
              String reps = '';
              String name = '';
              String type = '';
              String? _chosenValue;
              showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  backgroundColor: Colors.teal[50],
                  context: context,
                  builder: (context) {
                    return Wrap(children: [
                      Center(
                        child: Column(
                          children: [
                            SizedBox(height: size.height * 0.03),
                            SizedBox(
                              height: size.height * 0.035,
                              child: Text(
                                "Input Patients' Exercise",
                                style: TextStyle(
                                    fontFamily: "Circular",
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: size.height * 0.02),
                            RoundedInputField(
                              icon: Icons.fitness_center,
                              hintText: "Exercise Name",
                              validate: (value) => value!.isEmpty
                                  ? 'Enter an exercise name'
                                  : null,
                              onChanged: (value) {
                                setState(() => name = value);
                              },
                            ),
                            TextFieldContainer(
                              input: DropdownButtonFormField<String>(
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return 'Please enter an exercise type';
                                    }
                                  },
                                  isExpanded: true,
                                  value: _chosenValue,
                                  style: TextStyle(
                                      color: Colors.grey[800],
                                      fontFamily: 'Circular',
                                      fontSize: 16),
                                  items: <String>[
                                    'Timed Exercise',
                                    'Counted Exercise',
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      child: Text(value),
                                      value: value,
                                    );
                                  }).toList(),
                                  hint: Text("What type of exercise"),
                                  onChanged: (dynamic value) {
                                    setState(() {
                                      type = value;
                                      _chosenValue = value;
                                    });
                                  }),
                            ),
                            RoundedNumberField(
                              icon: Icons.notes,
                              hintText: "Sets",
                              validate: (value) => value!.isEmpty
                                  ? 'Enter the number of sets'
                                  : null,
                              onChanged: (value) {
                                setState(() => sets = value);
                              },
                            ),
                            RoundedNumberField(
                              icon: Icons.notes,
                              hintText: "Reps",
                              validate: (value) => value!.isEmpty
                                  ? 'Enter the number of reps'
                                  : null,
                              onChanged: (value) {
                                setState(() => reps = value);
                              },
                            ),
                            SizedBox(height: size.height * 0.01),
                            RoundedButton(
                                text: "ADD",
                                press: () {
                                  Exercise set =
                                      Exercise(name, sets, reps, type);
                                  FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(widget.useruid)
                                      .update({
                                    "exercises":
                                        FieldValue.arrayUnion([set.toMap()]),
                                  });
                                  Navigator.pop(context);
                                  return showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Success!"),
                                          content: Text("$name was added!"),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Okay"))
                                          ],
                                        );
                                      });
                                }),
                            SizedBox(height: size.height * 0.04),
                          ],
                        ),
                      ),
                    ]);
                  });
            }));
  }
}
