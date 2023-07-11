import 'package:flutter/material.dart';
import 'package:star_coffee/constants/app_sizes.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Widget? myLeading;
  final String myTitle;
  final List<Widget> myActions;

  const CustomAppBar(
      {super.key,
      this.myLeading,
      required this.myTitle,
      required this.myActions});

  @override
  // final Size preferredSize; // default is 56.0
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: AppSizes.appBarHeight,
      leadingWidth: 80,
      leading: widget.myLeading,
      centerTitle: true,
      title: Text(widget.myTitle, style: AppStyles.getTextStyle(22)),
      actions: widget.myActions,
      backgroundColor: AppColors.background,
      elevation: 0,
    );
  }
}
