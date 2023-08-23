import 'package:flutter/material.dart';
import 'package:star_coffee/constants/app_strings.dart';
import 'package:star_coffee/constants/text_styles.dart';

class AuthDivider extends StatelessWidget {
  const AuthDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          const Expanded(child: Divider(endIndent: 12)),
          Text(
            AppStrings.orContinueWith,
            style: TextStyles.bodySm.secondary,
          ),
          const Expanded(child: Divider(indent: 12)),
        ],
      ),
    );
  }
}
