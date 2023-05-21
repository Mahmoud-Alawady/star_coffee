import 'package:flutter/material.dart';

class ClipBottomBar extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    var arcY = size.height * 0.6;

    path.moveTo(size.width, size.height);

    path.lineTo(0, size.height);

    path.lineTo(0, arcY);

    path.quadraticBezierTo(size.width * 0.5, 0, size.width, arcY);

    // path.lineTo(size.height * 0.5, size.height);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
