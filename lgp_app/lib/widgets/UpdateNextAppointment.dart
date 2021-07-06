import 'package:flutter/material.dart';
import 'package:lgp_app/widgets/rounded_button.dart';
import '../widgets/rounded_input_field.dart';
import '../widgets/rounded_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateAppointment extends StatefulWidget {
  final String useruid;
  const UpdateAppointment({Key? key, required this.useruid}) : super(key: key);
  @override
  _UpdateAppointmentState createState() => _UpdateAppointmentState();
}

class _UpdateAppointmentState extends State<UpdateAppointment> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        child: RoundedButton(
            text: 'Update Appointment',
            press: () {
              String date = '';
              showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  backgroundColor: Colors.teal[50],
                  context: context,
                  builder: (context) {
                    return Column(
                      children: [
                        SizedBox(height: size.height * 0.03),
                        SizedBox(
                          height: size.height * 0.035,
                          child: Text(
                            "Input Next Appointment Date",
                            style: TextStyle(
                                fontFamily: "Circular",
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        RoundedInputField(
                          icon: Icons.medication,
                          hintText: "Appointment Date",
                          validate: (value) =>
                              value!.isEmpty ? 'Enter an exercise name' : null,
                          onChanged: (value) {
                            setState(() => date = value);
                          },
                        ),
                        SizedBox(height: size.height * 0.03),
                        RoundedButton(
                            text: "UPDATE",
                            press: () {
                              FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(widget.useruid)
                                  .update({
                                "date": date,
                              });
                              Navigator.pop(context);
                              return showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Success!"),
                                      content: Text(
                                          "Date has been updated to : $date"),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("Okay"))
                                      ],
                                    );
                                  });
                            })
                      ],
                    );
                  });
            }));
  }
}
