import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/text_field_container.dart';

class RoundedNumberField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final String? Function(String?)? validate;

  const RoundedNumberField({
    Key? key,
    this.validate,
    this.hintText = "Dummy",
    this.icon = Icons.person,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      input: TextFormField(
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.number,
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
