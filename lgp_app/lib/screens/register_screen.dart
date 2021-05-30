import 'package:flutter/material.dart';
import 'package:lgp_app/services/auth.dart';
import 'package:lgp_app/widgets/or_divider.dart';
import '../widgets/rounded_input_field.dart';
import '../widgets/rounded_password_field.dart';
import '../widgets/rounded_button.dart';
import '../widgets/already_have_account.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/patient_or_physio_button.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  String error = "";
  String userType = "";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                  "Start Your Physio-cal Journey!",
                  textAlign: TextAlign.center,
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
                    "assets/images/register_image.png",
                    fit: BoxFit.contain,
                    height: size.height * 0.30,
                  ),
                ),
                RoundedLimitedField(
                  hintText: "What are you?",
                  onChanged: (value) {
                    setState(() => userType = value);
                  },
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
                  text: "REGISTER",
                  press: () async {
                    if (_formKey.currentState!.validate()) {
                      dynamic result =
                          await _auth.registerEmailPassword(email, password);
                      if (result == null) {
                        setState(() =>
                            error = "Please supply a valid email and password");
                      }
                    }
                  },
                ),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                ),
                AlreadyHaveAnAccountCheck(
                  login: false,
                  press: () {
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return SignIn();
                      }),
                    );*/
                    widget.toggleView();
                  },
                ),
                SizedBox(height: size.height * 0.02),
                OrDivider(),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Social_Icon(
                      iconSrc: "assets/images/google-plus.svg",
                      press: () {},
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.08),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Social_Icon extends StatelessWidget {
  final String iconSrc;
  final Function() press;

  const Social_Icon({
    Key? key,
    required this.iconSrc,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: Colors.teal,
            ),
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(
            iconSrc,
            height: 20,
            width: 20,
          )),
    );
  }
}
