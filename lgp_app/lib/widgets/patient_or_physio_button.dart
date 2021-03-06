import 'package:flutter/material.dart';
import '../widgets/text_field_container.dart';

class RoundedLimitedField extends StatefulWidget {
  final String hintText;
  final IconData icon;
  //var onChanged;
  //final String? chosenValue;

  //final ValueChanged<dynamic> onChanged;

   RoundedLimitedField({
    Key? key,
    this.hintText = "Dummy",
    this.icon = Icons.star,
    //required this.onChanged,
    //required this.chosenValue,
  }) : super(key: key);

  @override
  _RoundedLimitedFieldState createState() => _RoundedLimitedFieldState();
}

class _RoundedLimitedFieldState extends State<RoundedLimitedField> {
  String? _chosenValue;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      input: DropdownButton<String>(
        isExpanded: true,
        value: _chosenValue,
        style: TextStyle(color: Colors.grey[800], fontFamily: 'Circular', fontSize: 16),
        items: <String>[
          'Patient',
          'Physiotherapist',
        ].map<DropdownMenuItem<String>>((String value){
          return DropdownMenuItem<String>(
            child: Text(value),
            value: value,
          );
        }).toList(),
        hint: Text("What are you"),
        onChanged: (dynamic value) {
          setState(() {
            _chosenValue = value;
          });
        }
      ),
    );
  }
}
