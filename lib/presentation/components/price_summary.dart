import 'package:flutter/material.dart';
import 'package:star_coffee/constants/globals.dart';
import 'package:star_coffee/data/price_summary_model.dart';
import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';
import 'clip_rount_top.dart';

class PriceSummary extends StatelessWidget {
  final Widget myDiv = const Divider(
    color: AppColors.background,
    height: 22,
  );

  final PriceSummaryModel p;
  const PriceSummary({required this.p, super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: ClipPath(
        clipper: ClipRoundTop(),
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: Globals.summaryHeight,
          color: AppColors.primary,
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: Globals.horizontalPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildSummaryRow('Subtotal', p.subtotal),
                myDiv,
                _buildSummaryRow('Shipping Cost', p.shippingCost),
                myDiv,
                _buildSummaryRow('Taxes', p.taxes),
                myDiv,
                _buildSummaryRow('Total', p.total),
                myDiv,
                SizedBox(height: Globals.bottomBarHeight - 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildSummaryRow(String text, double value) {
    TextStyle style = TextStyles.title.bgColor;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text, style: style),
        Text('\$ $value', style: style),
      ],
    );
  }
}
