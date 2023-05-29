import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:star_coffee/data/cart_item.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_paths.dart';
import '../../constants/app_styles.dart';
import '../drink_details.dart';
import 'cart_list_item.dart';

class CartDrinksList extends StatelessWidget {
  List<CartItem>? cartItems;
  late Size screenSize;
  double horizontalPadding = 14;

  CartDrinksList({
    super.key,
    required this.cartItems,
  });

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return ListView.builder(
      padding: EdgeInsets.only(
          bottom: screenSize.height / 2,
          left: horizontalPadding,
          right: horizontalPadding),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: cartItems!.length,
      itemBuilder: (context, index) {
        return CartListItem(cartItem: cartItems![index]);
      },
    );
  }
}
