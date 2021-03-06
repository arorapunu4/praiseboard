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

class BillBoardScreen extends StatefulWidget {
  final List<TextData> textData;
  final String bgColor;

  BillBoardScreen({this.textData, this.bgColor});
  @override
  _BillBoardScreenState createState() => _BillBoardScreenState();
}

class _BillBoardScreenState extends State<BillBoardScreen> {
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
            padding: EdgeInsets.fromLTRB(150.w, 100.w, 150.w, 100.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.textData[0].key,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 120.f,
                      color: AppColors.heading1),
                ),
                (widget.textData.length>1)
                    ? Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Text(
                          widget.textData[1].key,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 80.f,
                              color: AppColors.heading1),
                        ),
                    )
                    : Text(""),
                (widget.textData.length>2)
                    ? Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Text(
                          widget.textData[2].key,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 60.f,
                              color: AppColors.heading1),
                        ),
                    )
                    : Text(""),
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
