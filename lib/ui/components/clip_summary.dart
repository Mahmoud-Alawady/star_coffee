import 'package:flutter/material.dart';

class ClipSummary extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double arcY = size.height * 0.2;

    Path path = Path();
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
