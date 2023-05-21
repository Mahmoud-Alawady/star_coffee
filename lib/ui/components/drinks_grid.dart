import 'package:flutter/material.dart';
import '../../data/drink.dart';
import 'grid_item.dart';

class DrinksGrid extends StatelessWidget {
  DrinksGrid({super.key});
  List<Drink> drinks = [];

  @override
  Widget build(BuildContext context) {
    drinks = [
      Drink.dump(),
      Drink.dump(),
      Drink.dump(),
      Drink.dump(),
      Drink.dump(),
      Drink.dump(),
      Drink.dump(),
      Drink.dump(),
      Drink.dump(),
      Drink.dump(),
      Drink.dump(),
      Drink.dump(),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GridView.builder(
        physics: const BouncingScrollPhysics(
            decelerationRate: ScrollDecelerationRate.normal),
        itemCount: drinks.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).size.width < 600 ? 2 : 4,
          crossAxisSpacing: 10,
          mainAxisExtent: 250,

          // childAspectRatio: 0.65,
        ),
        itemBuilder: (context, index) {
          return GridItem(
            image: drinks[index].image,
            title: drinks[index].title,
            subtitle: drinks[index].subtitle,
            price: drinks[index].price,
            rate: drinks[index].rate,
          );
        },
      ),
    );
  }
}
