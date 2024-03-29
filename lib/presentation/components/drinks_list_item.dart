import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_coffee/presentation/components/quantity_select.dart';
import '../../constants/app_strings.dart';
import '../../constants/text_styles.dart';
import '../../data/cart_item.dart';
import '../../providers/cart_provider.dart';
import '../drink_details.dart';

class DrinksListItem extends StatelessWidget {
  late final BuildContext context;
  final CartItem cartItem;
  final int index;
  final String imageTag;
  final List<String> sizes = ['Small', 'Medium', 'Large'];

  DrinksListItem({required this.cartItem, required this.index, super.key})
      : imageTag = AppStrings.listImageTag + index.toString();

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
          onTap: () {
            context.read<CartProvider>().editMode
                ? context.read<CartProvider>().selectedItems.contains(index)
                    ? context.read<CartProvider>().removeFromSelected(index)
                    : context.read<CartProvider>().addToSelected(index)
                : Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DrinkDetails.fromCart(
                          cartItem: cartItem,
                          index: index,
                        )));
          },
          child: buildContent()),
    );
  }

  buildContent() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: context.watch<CartProvider>().editMode
              ? context.watch<CartProvider>().selectedItems.contains(index)
                  ? Colors.grey
                  : Colors.white
              : Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(26))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildImage(),
          Expanded(child: buildDetails()),
          buildSizeQuantityColumn(),
        ],
      ),
    );
  }

  buildImage() {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Hero(
        tag: imageTag,
        child: ClipOval(
          child: Image.network(
            cartItem.drink.image,
            fit: BoxFit.cover,
            height: 90,
            width: 90,
          ),
        ),
      ),
    );
  }

  buildDetails() {
    Widget title = Text(
      cartItem.drink.title,
      style: TextStyles.title.secondary,
    );
    Widget subtitle = Text(
      cartItem.drink.subtitle,
      style: TextStyles.body.primaryLight,
    );
    Widget price = Text(
      '\$ ${cartItem.drink.price}',
      style: TextStyles.title.primary,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title,
        subtitle,
        price,
      ],
    );
  }

  buildSizeQuantityColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildSize(),
        const SizedBox(height: 4),
        buildQuantity(),
      ],
    );
  }

  buildSize() {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Text(
        sizes[cartItem.size],
        style: TextStyles.body.secondary,
      ),
    );
  }

  buildQuantity() {
    return QuantitySelect(
      initQuantity: cartItem.quantity,
      onQuantitySelected: (newQuantity) {
        cartItem.quantity = newQuantity;
        context
            .read<CartProvider>()
            .editCartItem(cartItem: cartItem, index: index);
      },
      miniSize: true,
    );
  }
}
