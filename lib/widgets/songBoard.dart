import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:praiseboard/colors.dart';
import 'package:praiseboard/images.dart';
import 'package:praiseboard/models/boardModel.dart';
import 'package:praiseboard/responsiveness.dart';

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

class SongBoard extends StatefulWidget {
  final List<TextData> textData;
  final String bgColor;

  SongBoard({this.textData, this.bgColor});
  @override
  _SongBoardState createState() => _SongBoardState();
}

class _SongBoardState extends State<SongBoard> {
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
          color: Colors.white,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(90, 30, 90, 30),
              child: Container(
                  //height: double.infinity,
                  child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, mainAxisExtent: 100),
                      itemCount: widget.textData.length,
                      itemBuilder: (BuildContext context, int index) {
                        if ((index + 1).remainder(3) == 0) {
                          return Text(
                            widget.textData[index].key,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 50.f,
                                color: AppColors.heading1),
                          );
                        } else
                          return Text(
                            widget.textData[index].key,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 80.f,
                                color: AppColors.heading1),
                          );
                      })),
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
