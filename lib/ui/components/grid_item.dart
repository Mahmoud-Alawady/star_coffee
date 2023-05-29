import 'package:flutter/material.dart';
import 'package:star_coffee/data/cart_database.dart';
import 'package:star_coffee/data/cart_item.dart';
import 'package:star_coffee/ui/drink_details.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';
import '../../data/drink.dart';

class GridItem extends StatelessWidget {
  final Drink drink;

  const GridItem(this.drink, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 45, bottom: 5),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return DrinkDetails.fromHome(drink: drink);
            },
          ));
        },
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            buildBody(),
            buildImage(),
          ],
        ),
      ),
    );
  }

  buildImage() {
    return Positioned(
      top: -45,
      left: 0,
      right: 0,
      child: Align(
        alignment: Alignment.center,
        child: ClipOval(
          child: Image.network(
            drink.image,
            fit: BoxFit.cover,
            height: 90,
            width: 90,
          ),
        ),
      ),
    );
  }

  buildBody() {
    return Stack(
      children: [
        buildContent(),
        buildAddIcon(),
      ],
    );
  }

  buildContent() {
    Widget title = Text(drink.title,
        style: AppStyles.getTextStyle(16, AppColors.secondary));
    Widget subtitle = Text(drink.subtitle,
        style: AppStyles.getTextStyle(14, AppColors.primaryLight, 'Poppins'));

    Widget price = Text(
      '\$ ${drink.price}',
      style: AppStyles.getTextStyle(16, AppColors.secondary),
    );
    Widget rate = _buildRow(Icons.star, drink.rate.toString());
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(26))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 36),
            title,
            subtitle,
            const SizedBox(height: 0.5),
            price,
            rate,
          ],
        ),
      ),
    );
  }

  buildAddIcon() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        decoration: const BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(26),
                topLeft: Radius.circular(26))),
        child: InkWell(
          onTap: () {
            CartDatabase.insertRecord(
                cartItem: CartItem(
                    drink: drink, milkAmount: 50, size: 1, quantity: 1));
          },
          child: const Padding(
            padding: EdgeInsets.all(8),
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  _buildRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.yellow,
          size: 24,
        ),
        Text(text, style: AppStyles.getTextStyle(16, Colors.black, 'Poppins')),
      ],
    );
  }
}
