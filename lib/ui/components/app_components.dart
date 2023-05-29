import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';
import 'clip_bottom_bar.dart';

class MyAppComponents {
  static double appBarHeight = 80;
  static double bottomBarHeight = 120;

  static Widget myAppBar(
      {Widget? myLeading,
      required String myTitle,
      required List<Widget> myActions}) {
    return AppBar(
      toolbarHeight: appBarHeight,
      leadingWidth: 80,
      leading: myLeading,
      centerTitle: true,
      title: Text(myTitle, style: AppStyles.getTextStyle(22)),
      actions: myActions,
      backgroundColor: AppColors.background,
      elevation: 0,
    );
  }

  static Widget buildIconButton({
    String? label,
    required String icon,
    required VoidCallback function,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: IconButton(
        icon: SvgPicture.asset(
          icon,
          height: 24,
          width: 24,
          semanticsLabel: label,
          fit: BoxFit.contain,
          colorFilter:
              const ColorFilter.mode(AppColors.primary, BlendMode.srcATop),
        ),
        onPressed: function,
      ),
    );
  }

  static Widget myBottomBar({
    required BuildContext context,
    required String text,
    required VoidCallback function,
  }) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ClipPath(
        clipBehavior: Clip.antiAlias,
        clipper: ClipBottomBar(),
        child: InkWell(
          onTap: function,
          child: Container(
            height: bottomBarHeight,
            width: MediaQuery.of(context).size.width,
            color: AppColors.secondary,
            child: Align(
              alignment: Alignment.bottomCenter,
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
    );
  }
}
