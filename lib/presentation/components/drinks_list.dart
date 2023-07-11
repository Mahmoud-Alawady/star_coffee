import 'package:flutter/material.dart';
import 'package:star_coffee/data/cart_item.dart';
import 'drinks_list_item.dart';

class DrinksList extends StatelessWidget {
  List<CartItem>? cartItems;

  late Size screenSize;
  double horizontalPadding = 14;

  DrinksList({
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
        return DrinksListItem(cartItem: cartItems![index], index: index);
      },
    );
  }
}
