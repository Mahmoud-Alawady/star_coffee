import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/app_colors.dart';

class CustomIconButton extends StatelessWidget {
  final String? label = '';
  final String icon;
  final VoidCallback function;

  const CustomIconButton({
    super.key,
    String? label,
    required this.icon,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
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
}
