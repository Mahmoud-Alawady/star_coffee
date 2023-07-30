import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../constants/app_paths.dart';
import '../../constants/app_styles.dart';

typedef IntCallback = void Function(int newQuantity);

class QuantitySelect extends StatefulWidget {
  final IntCallback onQuantitySelected;
  int quantity;
  bool miniSize = false;

  QuantitySelect(
      {required this.quantity,
      required this.onQuantitySelected,
      this.miniSize = false,
      super.key});

  @override
  State<QuantitySelect> createState() => _QuantitySelectState();
}

class _QuantitySelectState extends State<QuantitySelect> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildQuantityEdit(false),
        Text(
          widget.quantity.toString(),
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
      width: widget.miniSize ? 38 : null,
      height: widget.miniSize ? 38 : null,
      child: IconButton(
          onPressed: () {
            setState(() {
              increase
                  ? widget.quantity++
                  : (widget.quantity > 1)
                      ? widget.quantity--
                      : print('can\'t have less that 1');
            });
            widget.onQuantitySelected(widget.quantity);
            print('quantity: ${widget.quantity}');
          },
          icon: SvgPicture.asset(increase ? AppPaths.plus : AppPaths.minus)),
    );
  }
}
