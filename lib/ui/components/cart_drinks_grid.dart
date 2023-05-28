import 'package:flutter/material.dart';
import 'package:star_coffee/data/cart_item.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';
import '../../data/drink.dart';
import '../drink_details.dart';
import 'grid_item.dart';

class CartDrinksGrid extends StatelessWidget {
  CartDrinksGrid({
    super.key,
    this.drinks,
  });
  List<CartItem>? drinks = [];

  @override
  Widget build(BuildContext context) {
    // drinks = [
    //   Drink.dump0(),
    //   Drink.dump1(),
    //   Drink.dump2(),
    //   Drink.dump3(),
    //   Drink.dump4(),
    //   Drink.dump1(),
    //   Drink.dump3(),
    //   Drink.dump2(),
    //   Drink.dump0(),
    //   Drink.dump4(),
    // ];

    return GridView.builder(
      padding: const EdgeInsets.only(bottom: 140, left: 10, right: 10),
      physics: const BouncingScrollPhysics(
          decelerationRate: ScrollDecelerationRate.normal),
      itemCount: drinks!.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width < 600 ? 2 : 4,
        crossAxisSpacing: 10,
        mainAxisExtent: 230,
      ),
      itemBuilder: (context, index) {
        return CartGridItem(drinks![index]);
      },
    );
  }
}

class CartGridItem extends StatelessWidget {
  final CartItem cartDrink;

  const CartGridItem(this.cartDrink, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 45, bottom: 5),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return DrinkDetails(drink: cartDrink);
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
            cartDrink.drink.image,
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
    Widget title = Text(cartDrink.drink.title,
        style: AppStyles.getTextStyle(16, AppColors.secondary));
    Widget subtitle = Text(cartDrink.drink.subtitle,
        style: AppStyles.getTextStyle(14, AppColors.primaryLight, 'Poppins'));

    Widget price = Text(
      '\$ ${cartDrink.drink.price}',
      style: AppStyles.getTextStyle(16, AppColors.secondary),
    );
    Widget rate = _buildRow(Icons.star, cartDrink.quantity.toString());
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
            print('Hello');
            // add function
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
