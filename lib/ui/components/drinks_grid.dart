import 'package:flutter/material.dart';
import '../../data/drink.dart';
import 'grid_item.dart';

class DrinksGrid extends StatelessWidget {
  DrinksGrid({
    super.key,
    this.drinks,
  });
  List<Drink>? drinks = [];

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
      physics: const BouncingScrollPhysics(),
      // physics: const NeverScrollableScrollPhysics(),
      // shrinkWrap: true,
      itemCount: drinks!.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width < 600 ? 2 : 4,
        crossAxisSpacing: 10,
        mainAxisExtent: 225,
      ),
      itemBuilder: (context, index) {
        return GridItem(drinks![index]);
      },
    );
  }
}
