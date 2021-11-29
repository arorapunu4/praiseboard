import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:praiseboard/colors.dart';
import 'package:praiseboard/firebase.dart';
import 'package:praiseboard/images.dart';
import 'package:praiseboard/screens/loginScreen.dart';
import 'package:praiseboard/responsiveness.dart';

import 'custom_splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.configure();

  runApp(MaterialApp(
    home: MyApp(),
    theme: ThemeData(fontFamily: 'AdventSans'),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
   Function duringSplash = () {
    print('Something background process');
    int a = 123 + 23;
    print(a);

    if (a > 100)
      return 1;
    else
      return 2;
  };

  Map<int, Widget> op = {1: Login(), 2: Login()};
  Widget build(BuildContext context) {
    Responsiveness.init();
    // return SplashScreen(
    //   useLoader:false,
    //   seconds: 5,
    //   navigateAfterSeconds: Login(),
    //   title: Text(
    //     'PraiseBoard',
    //     style: TextStyle(
    //         fontWeight: FontWeight.bold, fontSize: 40.f, color: Colors.white),
    //   ),
    //   image: Image(
    //             image: AssetImage(Images.SPLASH_LOGO),
    //             width: 417.w,
    //             height: 200.h,
    //           ),
    //   backgroundColor: AppColors.primaryColor,
    //   loaderColor: Colors.white,
    // );
    return CustomSplash(
      imagePath: 'assets/images/splash_logo.png',
     // backGroundColor: Colors.blue,
       backGroundColor: Color(0xff2a33ff),
      animationEffect: 'zoom-in',
      logoSize: 60,
      home: Login(),
      customFunction: duringSplash,
      duration: 0,
      type: CustomSplashType.StaticDuration,
      outputAndHome: op,
    );
  }
}

// class AfterSplash extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {

//   }
// }
