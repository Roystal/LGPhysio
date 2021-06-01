import 'package:flutter/material.dart';
import 'package:lgp_app/services/auth.dart';
import '../widgets/rounded_input_field.dart';
import '../widgets/rounded_password_field.dart';
import '../widgets/rounded_button.dart';
import '../widgets/already_have_account.dart';
import '../widgets/sign_in_anon.dart';
import '../widgets/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading ?  Loading() : Scaffold(
      body: Container(
        color: Colors.teal[50],
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: size.height * 0.06),
                Text(
                  "Welcome Back",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    fontFamily: 'Circular',
                    color: Colors.teal[600],
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  child: Image.asset(
                    "assets/images/signin_image.png",
                    fit: BoxFit.contain,
                    height: size.height * 0.35,
                  ),
                ),
                RoundedInputField(
                  hintText: "Email",
                  validate: (value) => value!.isEmpty ? 'Enter an email' : null,
                  onChanged: (value) {
                    setState(() => email = value);
                  },
                ),
                RoundedPasswordField(
                  validate: (value) => value!.length < 6
                      ? 'Enter a password 6+ chars long'
                      : null,
                  onChanged: (value) {
                    setState(() => password = value);
                  },
                ),
                SizedBox(height: size.height * 0.01),
                RoundedButton(
                  text: "LOGIN",
                  press: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() => loading = true);
                      dynamic result =
                          await _auth.signInEmailPassword(email, password);
                      if (result == null) {
                        setState(() {
                          error = "User does not exist";
                          loading = false;
                        });
                      }
                    }
                  },
                ),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                ),
                AlreadyHaveAnAccountCheck(
                  login: true,
                  press: () {
                    widget.toggleView();
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return Register(toggleView: toggleView(),);
                      }),
                    );*/
                  },
                ),
                SizedBox(height: size.height * 0.03),
                SignInAnon(auth: _auth),
                SizedBox(height: size.height * 0.13),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
