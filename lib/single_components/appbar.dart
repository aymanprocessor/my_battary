import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_battary/utils/common.dart';

Widget CustomAppBar(String title) {
  final common = Common();
  return AppBar(
    title: Text("$title",
        style:
            TextStyle(fontFamily: common.fontFamily, package: common.fontPack)),
    centerTitle: true,
    flexibleSpace: Container(
      decoration: BoxDecoration(gradient: common.purpleGradient),
    ),
  );
}
