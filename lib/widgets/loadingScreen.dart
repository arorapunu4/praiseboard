import 'package:flutter/material.dart';
import 'package:praiseboard/colors.dart';
import 'package:praiseboard/responsiveness.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Container(
          color: Colors.blue,
          width: double.infinity,
          height: double.infinity,
          child: 
              Center(child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              )),
          ),
    );
  }
}
