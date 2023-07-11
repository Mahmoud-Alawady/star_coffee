import 'package:flutter/material.dart';

class ClipRoundTop extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double arcY = 72.0;

    path.moveTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, arcY);
    path.quadraticBezierTo(size.width * 0.5, 0, size.width, arcY);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
