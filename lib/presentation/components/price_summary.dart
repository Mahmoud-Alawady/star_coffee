import 'package:flutter/material.dart';
import 'package:star_coffee/constants/globals.dart' as globals;
import 'package:star_coffee/data/price_summary_model.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';
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
          height: globals.summaryHeight,
          color: AppColors.primary,
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: globals.horizontalPadding),
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
                SizedBox(height: globals.bottomBarHeight - 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildSummaryRow(String text, double value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: AppStyles.getTextStyle(16, AppColors.background),
        ),
        Text(
          '\$ $value',
          style: AppStyles.getTextStyle(16, AppColors.background),
        ),
      ],
    );
  }
}
