import 'package:flutter/material.dart';
import '../widgets/text_field_container.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String? Function(String?)? validate;

  const RoundedPasswordField({
    Key? key,
    this.validate,
    required this.onChanged,
  }) : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      input: TextFormField(
        validator: widget.validate,
        obscureText: _obscureText,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: Colors.teal,
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.visibility),
            color: Colors.teal,
            onPressed: () {
              _toggle();
            },
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
