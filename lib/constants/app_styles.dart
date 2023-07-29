import 'package:flutter/material.dart';
import 'package:star_coffee/constants/app_strings.dart';
import 'app_colors.dart';

class AppStyles {
  static getTextStyle([
    double size = 18,
    Color color = AppColors.secondary,
    String family = AppStrings.primaryFont,
    FontWeight? weight,
  ]) {
    return TextStyle(
      fontFamily: family,
      fontSize: size,
      color: color,
      fontWeight: weight,
    );
  }
}
