import 'package:flutter/material.dart';
import 'package:lgp_app/services/auth.dart';

class SignInAnon extends StatelessWidget {
  const SignInAnon({
    Key? key,
    required AuthService auth,
  }) : _auth = auth, super(key: key);

  final AuthService _auth;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text("Sign in Anonymously"),
      onPressed: () async {
        dynamic result = await _auth.signInAnon(); 
        if(result == null) {
          print('error signing in');
        } else {
          print('signed in');
          print(result.uid);
        }
      },
      style: TextButton.styleFrom(
        backgroundColor: Colors.teal[600],
        primary: Colors.white,
      ),
    );
  }
}