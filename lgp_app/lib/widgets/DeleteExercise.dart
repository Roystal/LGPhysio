import 'package:flutter/material.dart';
import 'package:lgp_app/models/exercises.dart';
import 'package:lgp_app/widgets/rounded_button.dart';
import '../widgets/rounded_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeleteExercise extends StatefulWidget {
  final String nameofworkout;
  final String useruid;
  final Exercise exercise;
  const DeleteExercise(
      {Key? key, required this.nameofworkout, required this.useruid, required this.exercise})
      : super(key: key);

  @override
  _DeleteExerciseState createState() => _DeleteExerciseState();
}

class _DeleteExerciseState extends State<DeleteExercise> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          padding: EdgeInsets.all(20),
          child: RoundedButton(
            text: "Delete Exercise",
            press: () async {
              /*DocumentReference docRef = FirebaseFirestore.instance.collection('users').doc(widget.useruid);
          DocumentSnapshot doc = await docRef.get();
          List tags = (doc.data() as dynamic)['exercises'];
          if(tags.contains(widget.nameofworkout) == true){
            docRef.update(
              {
                'tags': FieldValue.arrayRemove([widget.nameofworkout])
              }
            );
          }*/
              var collection = FirebaseFirestore.instance.collection('users');
              collection.doc(widget.useruid).update({
                'exercises': FieldValue.arrayRemove([widget.exercise.toMap()]),
              });
              Navigator.pop(context);
                              return showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Success!"),
                                      content:
                                          Text("${widget.nameofworkout} has been deleted. Refresh page to view changes"),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("Okay"))
                                      ],
                                    );
                                  });

            },
          )),
    );
  }
}
