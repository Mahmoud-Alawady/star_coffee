import 'package:flutter/material.dart';
import 'package:star_coffee/constants/text_styles.dart';

class GoTo extends StatelessWidget {
  const GoTo({
    required this.text1,
    required this.text2,
    required this.routeBuilder,
    super.key,
  });

  final String text1;
  final String text2;
  final Widget Function(BuildContext context) routeBuilder;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: routeBuilder,
          ));
        },
        child: RichText(
          text: TextSpan(
            text: text1,
            style: TextStyles.title2.s14.grey,
            children: [
              TextSpan(
                text: text2,
                style: TextStyles.title2.s14.red.underline,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
