library star_coffee.globals;

import 'package:flutter/material.dart';

double appBarHeight = 80;
double bottomBarHeight = 120;
double summaryHeight = 344;
double horizontalPadding = 26;

late Size screenSize;
late double curveHeight;

setScreenSize(Size size) {
  screenSize = size;
  curveHeight = size.width / 5;
  //screenSize Set: 360.0 : 756.0 and curve height: 72.0
}
