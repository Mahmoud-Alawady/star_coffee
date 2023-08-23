import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../constants/app_paths.dart';
import '../../constants/text_styles.dart';

typedef IntCallback = void Function(int newQuantity);

class QuantitySelect extends StatefulWidget {
  final IntCallback onQuantitySelected;
  final int initQuantity;
  final bool miniSize;

  const QuantitySelect(
      {required this.initQuantity,
      required this.onQuantitySelected,
      this.miniSize = false,
      super.key});

  @override
  State<QuantitySelect> createState() => _QuantitySelectState();
}

class _QuantitySelectState extends State<QuantitySelect> {
  late int quantity;

  @override
  void initState() {
    quantity = widget.initQuantity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildQuantityEdit(false),
        Text(
          quantity.toString(),
          style: widget.miniSize
              ? TextStyles.title.s14.secondary
              : TextStyles.title.secondary,
        ),
        buildQuantityEdit(true),
      ],
    );
  }

  buildQuantityEdit(bool increase) {
    return SizedBox(
      width: widget.miniSize ? 38 : 44,
      height: widget.miniSize ? 38 : 44,
      child: IconButton(
          onPressed: () {
            setState(() {
              increase ? quantity++ : decreaseQuantity();
            });
            widget.onQuantitySelected(quantity);
          },
          icon: SvgPicture.asset(increase ? AppPaths.plus : AppPaths.minus)),
    );
  }

  void decreaseQuantity() {
    if (quantity > 1) {
      quantity--;
    }
  }
}
