import 'package:flutter/material.dart';
import '../widgets/text_field_container.dart';

class RoundedLimitedField extends StatefulWidget {
  final String hintText;
  final IconData icon;
  //final ValueChanged<dynamic> onChanged;

  const RoundedLimitedField({
    Key? key,
    this.hintText = "Dummy",
    this.icon = Icons.star,
    //required this.onChanged,
  }) : super(key: key);

  @override
  _RoundedLimitedFieldState createState() => _RoundedLimitedFieldState();
}

class _RoundedLimitedFieldState extends State<RoundedLimitedField> {
  int _value =  0;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      input: DropdownButton(
        isExpanded: true,
        value: _value,
        //onChanged: widget.onChanged,
        style: TextStyle(color: Colors.grey[800], fontFamily: 'Circular', fontSize: 16),
        onChanged: (dynamic value) {
          setState(() {
            _value = value;
          });
        },
        items: <DropdownMenuItem>[
          DropdownMenuItem(
            child: Text("I am a..."),
            value: 0,
          ),
          DropdownMenuItem(
            child: Text("Patient"),
            value: 1,
          ),
          DropdownMenuItem(
            child: Text("Physiotherapist"),
            value: 2,
          ),
        ],
        hint: Text("What are you"),
      ),
    );
  }
}
