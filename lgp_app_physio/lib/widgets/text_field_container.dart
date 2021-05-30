import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget input;
  const TextFieldContainer({
    Key? key,
    required this.input,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.teal[200],
        borderRadius: BorderRadius.circular(29),
      ),
      child: input,
    );
  }
}
