import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lgp_app/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:lgp_app/models/custom_user.dart';
import 'patient_homepage.dart';
import 'physiotherapist_homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Wrapper extends StatefulWidget {

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  Future<String?> getUserType(String uid) async {
    try {
      DocumentSnapshot _docSnapShot = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      var userType = await ( _docSnapShot.data() as dynamic)['userType'];
      print(userType);
      return await userType;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);

    return user == null ? Authenticate() : FutureBuilder(future: getUserType(user.uid), builder: (context,snapshot) {
                if(snapshot.hasData && snapshot.data == "Patient") {
                  return PatientHome();
                } else {
                  return PhysioHome();
                }
    });
  }
}

    //return either Home or Authenticate widget
    /*if ( user == null) {
      print("this");
      return Authenticate();
    } else if (getUserType(user.uid) == "Patient") {
      print('this happens');
      return PatientHome();
    } else {
      print(getUserType(user.uid).toString() + "this thing");
      return PhysioHome();
    }
  }
}*/



 /*   final user = Provider.of<CustomUser?>(context);
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
}*/