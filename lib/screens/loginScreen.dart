import 'package:flutter/material.dart';
import 'package:praiseboard/colors.dart';
import 'package:praiseboard/images.dart';
import 'package:praiseboard/navigation.dart';
import 'package:praiseboard/responsiveness.dart';
import 'package:praiseboard/routes.dart';
import 'package:praiseboard/screens/dashboard.dart';
import 'package:praiseboard/widgets/enterCode.dart';
import 'package:praiseboard/widgets/primaryBtn.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _codevalue = "";

  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    myController.addListener(_printLatestValue);
  }

  void _printLatestValue() {
    print('Second text field: ${myController.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Padding(
        padding: EdgeInsets.fromLTRB(0, 115.vs, 0, 60.vs),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image(
                image: AssetImage(Images.LOGIN_LOGO),
                width: 417.w,
                height: 78.h,
              ),
            ),
            // TextField(
            //   controller: myController,
            // ),
            SizedBox(
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter code here '),
                onChanged: (text) {
                  if (text != "") {
                    setState(() {
                      _codevalue = text;
                    });
                  }
                  print('First text field: $text');
                },
                onSubmitted :(text){
                  if (text != "") {
                        Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) =>
                            DashboardContainer(code: text)));
                  }

                }
              ),
              width: 300,
            ),

            SizedBox(height: 20.h),
            PrimaryButton(
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) =>
                            DashboardContainer(code: _codevalue)));
              },
              text: "SUBMIT",
              isLoading: false,
            ),
            //    EnterCode(),
            Center(
              child: Text(
                'The code is with your admin',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26.f,
                    color: AppColors.heading1),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
