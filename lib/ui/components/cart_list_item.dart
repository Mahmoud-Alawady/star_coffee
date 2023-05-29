import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:star_coffee/data/cart_database.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_paths.dart';
import '../../constants/app_styles.dart';
import '../../data/cart_item.dart';
import '../drink_details.dart';

class CartListItem extends StatelessWidget {
  final CartItem cartItem;
  final List<String> sizes = ['Small', 'Medium', 'Large'];

  CartListItem({required this.cartItem, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return DrinkDetails.fromCart(cartItem: cartItem);
              },
            ));
            print(cartItem.id);
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(26))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildImage(),
                Expanded(child: buildDetails()),
                buildSizeQuantity(),
              ],
            ),
          )),
    );
  }

  buildImage() {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ClipOval(
        child: Image.network(
          cartItem.drink.image,
          fit: BoxFit.cover,
          height: 90,
          width: 90,
        ),
      ),
    );
  }

  buildDetails() {
    Widget title = Text(cartItem.drink.title,
        style: AppStyles.getTextStyle(16, AppColors.secondary));
    Widget subtitle = Text(cartItem.drink.subtitle,
        style: AppStyles.getTextStyle(14, AppColors.primaryLight, 'Poppins'));
    Widget price = Text(
      '\$ ${cartItem.drink.price}',
      style: AppStyles.getTextStyle(16, AppColors.secondary),
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

  buildQuantity() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        buildQuantityEdit(false),
        Text(
          cartItem.quantity.toString(),
          style: AppStyles.getTextStyle(16, Colors.black, 'Poppins'),
        ),
        buildQuantityEdit(true),
      ],
    );
  }

  buildQuantityEdit(bool increase) {
    return SizedBox(
      width: 38,
      height: 38,
      child: IconButton(
          onPressed: () {
            increase
                ? cartItem.quantity++
                : (cartItem.quantity > 1)
                    ? cartItem.quantity--
                    : print('can\'t have less that 1');
            CartDatabase.editRecordQuantity(cartItem: cartItem);
            print('id: ${cartItem.id}');
            print('quantity: ${cartItem.quantity}');
          },
          icon: SvgPicture.asset(
            increase ? AppPaths.plus : AppPaths.minus,
          )),
    );
  }

  buildSizeQuantity() {
    Widget size = Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Text(
        sizes[cartItem.size],
        style: AppStyles.getTextStyle(14, AppColors.secondary, 'Poppins'),
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        size,
        const SizedBox(height: 4),
        buildQuantity(),
      ],
    );
  }
}
