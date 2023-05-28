import 'package:flutter/material.dart';
import 'package:star_coffee/data/cart_database.dart';
import 'package:star_coffee/ui/components/drinks_grid.dart';
import '../data/drink.dart';
import 'components/cart_drinks_grid.dart';

class Cart extends StatelessWidget {
  Cart({super.key});
  List<Drink> drinks = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: CartDatabase.getRecord(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return CartDrinksGrid(
            drinks: snapshot.data,
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
