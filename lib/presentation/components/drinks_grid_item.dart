import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_coffee/constants/app_strings.dart';
import 'package:star_coffee/presentation/drink_details.dart';
import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';
import '../../data/drink.dart';
import '../../providers/cart_provider.dart';

class DrinksGridItem extends StatelessWidget {
  final Drink drink;
  final int index;
  final String imageTag;
  late BuildContext context;

  DrinksGridItem(this.drink, this.index, {super.key})
      : imageTag = AppStrings.gridImageTag + index.toString();

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Padding(
      padding: const EdgeInsets.only(top: 45, bottom: 5),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return DrinkDetails.fromHome(
                drink: drink,
                index: index,
              );
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
        child: Hero(
          tag: imageTag,
          child: ClipOval(
            child: Image.network(
              drink.image,
              fit: BoxFit.cover,
              height: 90,
              width: 90,
            ),
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
    Widget title = Text(
      drink.title,
      style: TextStyles.title.secondary,
    );
    Widget subtitle = Text(drink.subtitle, style: TextStyles.body.primaryLight);

    Widget price = Text(
      '\$ ${drink.price}',
      style: TextStyles.title.secondary,
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
    const roundBorder = BorderRadius.only(
        bottomRight: Radius.circular(26), topLeft: Radius.circular(26));

    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.primary,
          borderRadius: roundBorder,
        ),
        child: InkWell(
          borderRadius: roundBorder,
          onTap: () {
            context.read<CartProvider>().addItemQuick(drink: drink);
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
        Text(text, style: TextStyles.body.black),
      ],
    );
  }
}
