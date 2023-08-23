import 'package:flutter/material.dart';

abstract class Globals {
  static double appBarHeight = 80;
  static double bottomBarHeight = 120;
  static double summaryHeight = 344;
  static double horizontalPadding = 26;

  static late Size screenSize;
  static late double curveHeight;
  static late double navRailWidth;
  static late double navRailHeight;

  static setScreenSize(Size size) {
    screenSize = size;
    curveHeight = size.width / 5;
    navRailWidth = size.width * 0.15;
    navRailHeight = (size.height - appBarHeight) * 0.86;
  }
}
