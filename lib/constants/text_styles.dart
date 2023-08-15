import 'package:flutter/material.dart';
import 'app_colors.dart';

// class AppStyles {
//   static getTextStyle([
//     double size = 18,
//     Color color = AppColors.secondary,
//     String family = AppStrings.primaryFont,
//     FontWeight? weight,
//   ]) {
//     return TextStyle(
//       fontFamily: family,
//       fontSize: size,
//       color: color,
//       fontWeight: weight,
//     );
//   }
// }

class Fonts {
  static String get title => 'Archivo';
  static String get title2 => 'Inter';
  static String get body => 'Poppins';
}

class FontSizes {
  static double scale = 1;

  static double get title => 16 * scale;
  static double get titleL => 18 * scale;
  static double get titleXL => 22 * scale;
  static double get body => 14 * scale;
  static double get bodySm => 12 * scale;
}

class TextStyles {
  static TextStyle get _titleFont => TextStyle(fontFamily: Fonts.title);
  static TextStyle get _titleFont2 => TextStyle(fontFamily: Fonts.title2);
  static TextStyle get _bodyFont => TextStyle(fontFamily: Fonts.body);

  static TextStyle get title => _titleFont.copyWith(fontSize: FontSizes.title);
  static TextStyle get title2 =>
      _titleFont2.copyWith(fontSize: FontSizes.title);
  static TextStyle get titleXL =>
      _titleFont.copyWith(fontSize: FontSizes.titleXL);
  static TextStyle get titleL =>
      _titleFont.copyWith(fontSize: FontSizes.titleL);

  static TextStyle get body => _bodyFont.copyWith(fontSize: FontSizes.body);
  static TextStyle get bodySm => body.copyWith(fontSize: FontSizes.bodySm);
}

extension TextStyleHelpers on TextStyle {
  TextStyle get primary => copyWith(color: AppColors.primary);
  TextStyle get primaryLight => copyWith(color: AppColors.primaryLight);
  TextStyle get secondary => copyWith(color: AppColors.secondary);
  TextStyle get bgColor => copyWith(color: AppColors.background);
  TextStyle get white => copyWith(color: Colors.white);
  TextStyle get black => copyWith(color: Colors.black);
  TextStyle get red => copyWith(color: Colors.red);
  TextStyle get grey => copyWith(color: Colors.grey);
  TextStyle get bold => copyWith(fontWeight: FontWeight.w900);
  TextStyle get s12 => copyWith(fontSize: 12);
  TextStyle get s14 => copyWith(fontSize: 14);
  TextStyle get s16 => copyWith(fontSize: 16);
  TextStyle get underline => copyWith(decoration: TextDecoration.underline);
}
