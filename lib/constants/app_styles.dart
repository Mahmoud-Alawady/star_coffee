import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppStyles {
  // static TextStyle titleStyle = const TextStyle(
  //     fontFamily: 'Archivo',
  //     fontSize: 22,
  //     // fontWeight: FontWeight.bold,
  //     color: AppColors.secondary);

  // static TextStyle nameStyle = const TextStyle(
  //     fontFamily: 'Archivo',
  //     fontSize: 20,
  //     // fontWeight: FontWeight.bold,
  //     color: AppColors.secondary);

  // static TextStyle welcomeStyle = const TextStyle(
  //     fontFamily: 'Archivo', fontSize: 16, color: AppColors.primary);

  static getTextStyle([double? size, Color? color, String? family]) {
    return TextStyle(
        fontFamily: family ?? 'Archivo',
        fontSize: size ?? 18,
        color: color ?? AppColors.secondary);
  }
}
