import 'package:flutter/material.dart';
import 'package:mytv/colors.dart';
import 'package:mytv/responsiveness.dart';

class ErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: new AppBar(
        title: new Text("Login Page"),
      ),
          body: Container(
          color: Colors.blue,
          child: Expanded(
                      child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                                child: Text(
                    'Please enter a valid code',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 42.f,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
