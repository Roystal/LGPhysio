import 'package:flutter/material.dart';
import 'package:lgp_app/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:lgp_app/models/custom_user.dart';
import 'patient_homepage.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    print(user);
    //return either Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
