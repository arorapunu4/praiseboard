import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mytv/models/boardModel.dart';
import 'package:mytv/services/boardservice.dart';
import 'package:mytv/widgets/billBoardScreen.dart';
import 'package:mytv/widgets/errorScreen.dart';
import 'package:mytv/widgets/loadingScreen.dart';
import 'package:mytv/widgets/noticeBoardScreen.dart';
import 'package:mytv/widgets/songBoard.dart';
import 'package:pretty_json/pretty_json.dart';

class DashboardContainer extends StatefulWidget {
  final String code;
  DashboardContainer({this.code});

  @override
  _DashboardContainerState createState() => _DashboardContainerState();
}

class _DashboardContainerState extends State<DashboardContainer> {
  Future eventLogList;
  FirebaseFirestore _instance;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _instance = FirebaseFirestore.instance;
    CollectionReference categories = _instance.collection('praiseboard');

    return new StreamBuilder(
        stream: categories.doc(widget.code).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Loading();
          }
          if (!snapshot.hasData || !snapshot.data.exists) {
            return ErrorScreen();
          }
          if (snapshot.hasData) {
            var userDocument = snapshot.data["data"]["finalData"];
            var screenType = snapshot.data["data"]["finalData"]['type'];

            print(userDocument["bgColor"]);
            print(screenType);

            List<TextData> list = List<TextData>.from(
                userDocument["textData"].map((i) => TextData.fromJson(i)));
            if (screenType == "SONG_BOARD_PAGE") {
              return SongBoard(
                  textData: list, bgColor: userDocument["bgColor"]);
            } else if (screenType == "BILL_BOARD_PAGE")
              return BillBoardScreen(
                  textData: list, bgColor: userDocument["bgColor"]);
            else {
              return NoticeBoardScreen(
                  textData: list, bgColor: userDocument["bgColor"]);
            }
          }

          if (snapshot.hasError) {}

          return ErrorScreen();
        });
  }
}
