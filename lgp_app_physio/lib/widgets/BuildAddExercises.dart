import 'package:flutter/material.dart';
import 'package:lgp_app/widgets/rounded_button.dart';

class BuildAddExercises extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: RoundedButton(
            text: 'Add exercise',
            press: () {
              print('Add exercise');
            }));
  }
}
