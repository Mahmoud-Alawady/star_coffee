import 'package:flutter/material.dart';
import 'package:star_coffee/constants/globals.dart' as globals;

class ClipRoundBottom extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height); //down
    path.quadraticBezierTo(size.width * 0.5, size.height - globals.curveHeight,
        size.width, size.height);
    path.lineTo(size.width, 0); //up

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
