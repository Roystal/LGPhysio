import 'package:flutter/material.dart';
import '../widgets/text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final String?Function(String?)? validate;

  const RoundedInputField({
    Key? key,
    this.validate,
    this.hintText = "Dummy",
    required this.icon,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      input: TextFormField(
        validator: validate,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          icon: Icon(
            icon,
            color: Colors.teal,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}