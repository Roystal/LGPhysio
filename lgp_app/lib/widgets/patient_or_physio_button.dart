import 'package:flutter/material.dart';
import '../widgets/text_field_container.dart';

class RoundedLimitedField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;

  const RoundedLimitedField({
    Key? key,
    this.hintText = "Dummy",
    this.icon = Icons.star,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      input: DropdownButton(
        items: <DropdownMenuItem>[
          DropdownMenuItem(
            child: Text("Patient"),
          ),
          DropdownMenuItem(
            child: Text("Physiotherapist"),
          ),
        ],
        hint: Text(hintText),
        ),
      );
  }
}
