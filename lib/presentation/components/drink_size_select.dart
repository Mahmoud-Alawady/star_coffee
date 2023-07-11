import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_paths.dart';
import '../../constants/app_styles.dart';

typedef IntCallback = void Function(int newSize);

class DrinkSizeSelect extends StatefulWidget {
  int size;
  final IntCallback onSizeSelected;

  DrinkSizeSelect({
    required this.size,
    required this.onSizeSelected,
    super.key,
  });

  @override
  State<DrinkSizeSelect> createState() => _DrinkSizeSelectState();
}

class _DrinkSizeSelectState extends State<DrinkSizeSelect> {
  List<String> sizeTitle = ['Small', 'Medium', 'Large'];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        buildSize(0),
        buildSize(1),
        buildSize(2),
      ],
    );
  }

  buildSize(int i) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 120,
          child: Center(
            child: buildSizeIcon(i),
          ),
        ),
        Text(sizeTitle[i],
            style: AppStyles.getTextStyle(
                14, widget.size == i ? Colors.black : Colors.grey, 'Poppins')),
      ],
    );
  }

  buildSizeIcon(int i) {
    const roundBorder = BorderRadius.all(Radius.circular(20));
    return Material(
      borderRadius: roundBorder,
      color: (widget.size == i) ? AppColors.primary : Colors.white,
      child: InkWell(
        onTap: () {
          setState(() {
            widget.size = i;
          });
          print('selectedSize: ${sizeTitle[widget.size]}');

          widget.onSizeSelected(i);
        },
        borderRadius: roundBorder,
        child: Ink(
          height: 78.0 + i * 12,
          width: 78.0 + i * 12,
          padding: const EdgeInsets.all(24),
          child: SvgPicture.asset(
            AppPaths.cup,
            colorFilter: (widget.size == i)
                ? const ColorFilter.mode(Colors.white, BlendMode.srcATop)
                : const ColorFilter.mode(AppColors.primary, BlendMode.srcATop),
          ),
        ),
      ),
    );
  }
}
