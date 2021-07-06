import 'package:flutter/material.dart';
import 'package:lgp_app/widgets/rounded_button.dart';
import '../widgets/rounded_input_field.dart';
import '../widgets/rounded_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateInjury extends StatefulWidget {
  final String useruid;
  const UpdateInjury({Key? key, required this.useruid}) : super(key: key);
  @override
  _UpdateInjuryState createState() => _UpdateInjuryState();
}

class _UpdateInjuryState extends State<UpdateInjury> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        child: RoundedButton(
            text: 'Update Patient Injury',
            press: () {
              String injury = '';
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
                            "Input Injury",
                            style: TextStyle(
                                fontFamily: "Circular",
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: size.height * 0.02),
                        RoundedInputField(
                          icon: Icons.personal_injury,
                          hintText: "Injury",
                          validate: (value) => value!.isEmpty
                              ? 'Enter Injury Name/Description'
                              : null,
                          onChanged: (value) {
                            setState(() => injury = value);
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
                                "injury": injury,
                              });
                              Navigator.pop(context);
                              return showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Success!"),
                                      content:
                                          Text("Patient Injury is : $injury"),
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
