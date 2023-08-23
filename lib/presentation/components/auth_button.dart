import 'package:flutter/material.dart';
import 'package:star_coffee/constants/app_colors.dart';
import 'package:star_coffee/constants/text_styles.dart';

class AuthButton extends StatelessWidget {
  final VoidCallback function;
  final String text;

  const AuthButton({required this.text, required this.function, super.key});

  @override
  Widget build(BuildContext context) {
    double height = 48;
    double padding = 5;
    double arrowSize = height - 2 * padding;
    return MaterialButton(
      onPressed: function,
      color: AppColors.primary,
      elevation: 0,
      padding: EdgeInsets.all(padding),
      minWidth: double.infinity,
      height: height,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              textAlign: TextAlign.center,
              text,
              style: TextStyles.title2.white.bold,
            ),
          ),
          Container(
            width: arrowSize,
            height: arrowSize,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
              color: Colors.white,
            ),
            child: const Icon(Icons.arrow_forward),
          ),
        ],
      ),
    );
  }
}
