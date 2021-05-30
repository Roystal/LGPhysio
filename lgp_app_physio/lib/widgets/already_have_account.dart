import 'package:flutter/material.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function() press;

  const AlreadyHaveAnAccountCheck({
    Key? key,
    this.login = true,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          login ? "Don't have an account? " : "Already have an account? ",
          style: TextStyle(
            color: Colors.teal,
            fontFamily: 'Circular',
          ),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "Sign Up" : "Sign In",
              style: TextStyle(
                  color: Colors.teal,
                  fontFamily: 'Circular',
                  fontWeight: FontWeight.w900)),
        ),
      ],
    );
  }
}
