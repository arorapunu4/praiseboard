import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mytv/colors.dart';
import 'package:mytv/images.dart';
import 'package:mytv/models/boardModel.dart';
import 'package:mytv/responsiveness.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class NoticeBoardScreen extends StatefulWidget {
  final List<TextData> textData;
  final String bgColor;

  NoticeBoardScreen({this.textData, this.bgColor});
  @override
  _NoticeBoardScreenState createState() => _NoticeBoardScreenState();
}

class _NoticeBoardScreenState extends State<NoticeBoardScreen> {
  List slide1;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color color1 = HexColor(widget.bgColor);

    widget.textData.forEach(
      (element) {},
    );

    return Scaffold(
        body: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Container(
          width: 1646.w,
          height: 100,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.fromLTRB(200.w, 100.w, 200.w, 100.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  widget.textData[0].key,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 100.f,
                      color: AppColors.heading1),
                ),
                Text(
                  widget.textData[1].key,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 60.f,
                      color: AppColors.heading1),
                )
              ],
            ),
          )),
      Container(
        width: 274.w,
        height: 100,
        color: color1,
        child: Stack(
          children: [
            Positioned(
              bottom: 30,
              left: 40,
              child: Column(
                children: [
                  Image(
                    image: AssetImage(Images.BG_LOGO),
                    width: 120.w,
                    height: 120.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    ]));
  }
}
