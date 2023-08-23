import 'package:flutter/material.dart';
import 'package:star_coffee/constants/globals.dart';

class ClipRoundTop extends CustomClipper<Path> {
  // double width;
  // ClipRoundTop({required this.width});

  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(size.width, size.height); //bottom right
    path.lineTo(0, size.height); //bottom left
    path.lineTo(0, Globals.curveHeight); //up to curve start
    path.quadraticBezierTo(size.width * 0.5, 0, size.width,
        Globals.curveHeight); //right to curve end

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
