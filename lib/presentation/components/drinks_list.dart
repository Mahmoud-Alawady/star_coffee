import 'package:flutter/material.dart';
import 'package:star_coffee/constants/globals.dart';
import 'package:star_coffee/data/cart_item.dart';
import 'drinks_list_item.dart';

class DrinksList extends StatelessWidget {
  final List<CartItem> cartItems;
  final double horizontalPadding = 14;

  const DrinksList({
    super.key,
    required this.cartItems,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(
          bottom: Globals.screenSize.height / 2,
          left: horizontalPadding,
          right: horizontalPadding),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        return DrinksListItem(cartItem: cartItems[index], index: index);
      },
    );
  }
}
