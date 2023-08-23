import 'package:flutter/material.dart';
import 'package:star_coffee/constants/globals.dart';
import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Widget? myLeading;
  final String myTitle;
  final TextStyle? style;
  final Widget myActions;

  const CustomAppBar(
      {super.key,
      this.myLeading,
      this.style,
      required this.myTitle,
      required this.myActions});

  @override
  // final Size preferredSize; // default is 56.0
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  CustomAppBarState createState() => CustomAppBarState();
}

class CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: Globals.appBarHeight,
      leadingWidth: 80,
      leading: widget.myLeading,
      centerTitle: true,
      title: Text(widget.myTitle,
          style: widget.style ?? TextStyles.titleXL.secondary),
      actions: [widget.myActions],
      backgroundColor: AppColors.background,
      elevation: 0,
    );
  }
}
