import 'package:flutter/material.dart';
import 'package:lgp_app/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lgp_app/widgets/editexerciserow.dart';
import '../models/exercises.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/loading.dart';

class EditPatient extends StatefulWidget {
  final String useruid;

  const EditPatient({Key? key, required this.useruid}) : super(key: key);
  @override
  _EditPatientState createState() => _EditPatientState();
}

class _EditPatientState extends State<EditPatient> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final AuthService _auth = AuthService();
  @override
  // build function
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        title: Text('Edit Patient Exercises'),
        backgroundColor: Colors.teal[400],
      ),
      body: FutureBuilder(
          future: getStuff(widget.useruid),
          builder: (context, AsyncSnapshot snapshots) {
            if (snapshots.data != null) {
              String AppointmentDate =
                  (snapshots.data as dynamic).data()["date"].toString();
              String InjuryType =
                  (snapshots.data as dynamic).data()["injury"].toString();
              if (snapshots.connectionState != ConnectionState.done) {
                return Loading();
              } else if (!snapshots.hasData) {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if ((snapshots.data! as dynamic)
                      .data()["exercises"]
                      .length ==
                  0) {
                return Center(
                  child: Column(
                    children: [
                      Container(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/no_patient_found.png",
                            fit: BoxFit.contain,
                            height: size.height * 0.30,
                          ),
                          Text("No exercises in the database"),
                        ],
                      )),
                    ],
                  ),
                );
              } else {
                return RefreshIndicator(
                  onRefresh: () => _refreshData(widget.useruid),
                  child: Column(mainAxisSize: MainAxisSize.max, children: [
                    Expanded(
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          itemCount: (snapshots.data! as dynamic)
                              .data()["exercises"]
                              .length,
                          itemBuilder: (context, index) {
                            Exercise exercising;
                            exercising = Exercise.fromMap(
                                (snapshots.data as dynamic).data()["exercises"]
                                    [index]);
                            print(exercising.exercise);
                            return Column(
                              children: [
                                Divider(),
                                Container(
                                  child: EditExerciseRow(
                                      exercise: exercising,
                                      userid: widget.useruid),
                                )
                              ],
                            );
                          }),
                    ),
                  ]),
                );
              }
            } else {
              return Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [CircularProgressIndicator()]),
              );
            }
          }),
    );
  }

  Future getStuff(String useruid) async {
    var docs;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(useruid)
        .get()
        .then((querySnapshot) {
      docs = querySnapshot;
    });
    return docs;
  }

  Future _refreshData(String useruid) async {
    await getStuff(useruid);
    setState(() {});
  }
}
