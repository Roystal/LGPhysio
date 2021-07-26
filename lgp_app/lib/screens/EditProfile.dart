import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lgp_app/widgets/rounded_button.dart';
import '../models/screen_data.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        backgroundColor: Colors.teal[400],
        title: Text("Edit Profile",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/edit_profile.png",
              fit: BoxFit.contain,
              height: size.height * 0.30,
            ),
            RoundedButton(text: "Update username and password", press: (){}),
            SizedBox(height: 10),
            RoundedButton(text: "Delete Account", press: (){
              User user = _auth.currentUser!;
              user.delete();
                              Navigator.pop(context);
                              return showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Success!"),
                                      content:
                                          Text("Account has been deleted"),
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
        ),
      ),
    );
  }
}
