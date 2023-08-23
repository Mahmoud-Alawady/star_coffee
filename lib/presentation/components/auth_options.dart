import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:star_coffee/constants/app_paths.dart';

class AuthOptions extends StatelessWidget {
  const AuthOptions({super.key});

  @override
  Widget build(BuildContext context) {
    const space = SizedBox(width: 6);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildBox(AppPaths.googleIcon, () {}),
        space,
        _buildBox(AppPaths.facebookIcon, () {}),
        space,
        _buildBox(AppPaths.twitterIcon, () {}),
      ],
    );
  }

  _buildBox(String icon, VoidCallback function) {
    const borderRadius = BorderRadius.all(Radius.circular(30));
    final decoration = BoxDecoration(
        borderRadius: borderRadius,
        border: Border.all(
          color: const Color.fromARGB(132, 0, 0, 0),
        ));

    return Expanded(
      child: InkWell(
        onTap: function,
        borderRadius: borderRadius,
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: decoration,
          child: SizedBox(height: 34, width: 34, child: SvgPicture.asset(icon)),
        ),
      ),
    );
  }
}
