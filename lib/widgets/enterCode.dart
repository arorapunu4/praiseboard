import 'package:flutter/material.dart';
import 'package:praiseboard/colors.dart';
import 'package:praiseboard/responsiveness.dart';
import 'package:praiseboard/widgets/primaryBtn.dart';
import 'package:praiseboard/widgets/text_form_field.dart';

class EnterCode extends StatefulWidget {
  @override
  _EnterCodeState createState() => _EnterCodeState();
}

class _EnterCodeState extends State<EnterCode> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Please enter the code',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28.f,
                  color: AppColors.heading1),
            ),
          ),
          LoginForm(),
        ],
      ),
    );
  }
}
