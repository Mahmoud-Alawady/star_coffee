import 'package:flutter/material.dart';
import 'package:star_coffee/constants/app_sizes.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';
import 'clip_rount_top.dart';

class BottomBar extends StatelessWidget {
  final String text;
  final VoidCallback function;
  const BottomBar({super.key, required this.text, required this.function});
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: AppSizes.bottomBarHeight,
        width: MediaQuery.of(context).size.width,
        child: ClipPath(
          clipBehavior: Clip.antiAlias,
          clipper: ClipRoundTop(),
          child: MaterialButton(
            color: AppColors.secondary,
            onPressed: function,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  text,
                  style: AppStyles.getTextStyle(18, AppColors.background)
                      .copyWith(height: 1.5),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
