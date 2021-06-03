import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lgp_app/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:lgp_app/models/custom_user.dart';
import 'patient_homepage.dart';
import 'physiotherapist_homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').doc(Provider.of<CustomUser?>(context)!.uid).snapshots(),
      builder: (context, snapshot) {
        if (Provider.of<CustomUser?>(context) == null) {
          return Authenticate();
        } else if ((snapshot.data as dynamic )["userType"].toString() == "Patient") {
      return PatientHome();
    } else {
      return PhysioHome();
    }
      }
  );
}
}




/*
    final user = Provider.of<CustomUser?>(context);
    final userDataType = FirebaseFirestore.instance.collection('users').doc(user!.uid).get() => then((value){
      print(value.data["userType"].toString());
    });

    print(user);
    //return either Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else if (userDataType == "Patient") {
      return PatientHome();
    } else {
      return PhysioHome();
    }

  }
}
*/