import 'package:flutter/material.dart';
import '../../data/drink.dart';
import 'drinks_grid_item.dart';

class DrinksGrid extends StatelessWidget {
  List<Drink>? drinks = [];

  DrinksGrid({super.key, this.drinks});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.only(bottom: 140, left: 10, right: 10),
      physics: const BouncingScrollPhysics(),
      itemCount: drinks!.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width < 600 ? 2 : 4,
        crossAxisSpacing: 10,
        mainAxisExtent: 225,
      ),
      itemBuilder: (context, index) {
        return DrinksGridItem(drinks![index], index);
      },
    );
  }
}
