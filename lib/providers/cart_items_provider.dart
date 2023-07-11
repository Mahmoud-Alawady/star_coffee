import 'package:flutter/foundation.dart';
import 'package:star_coffee/bussiness/price_summary_calc.dart';
import 'package:star_coffee/data/cart_database.dart';
import 'package:star_coffee/data/drink.dart';
import '../data/cart_item.dart';
import '../data/price_summary_model.dart';

// enum CartState { initial, loaded, error }

class CartItemsProvider with ChangeNotifier {
  bool _itemsLoaded = false;
  List<CartItem> _itemsList = [];

  bool get itemsLoaded => _itemsLoaded;

  List<CartItem> get cartItems => _itemsList;

  int get cartItemsCount => _itemsList.length;

  PriceSummaryModel get priceSummary =>
      PriceSummaryCalc.getPriceSummary(_itemsList);

  void getCartItemsFromDB() async {
    _itemsList = await CartDatabase.getCartItems();
    _itemsLoaded = true;
    notifyListeners();
  }

  void editCartItemQuantity({required CartItem cartItem}) async {
    await CartDatabase.editRecordQuantity(cartItem: cartItem);
    getCartItemsFromDB();
  }

  void editCartItem({required CartItem cartItem}) async {
    CartDatabase.editRecord(cartItem: cartItem);
    getCartItemsFromDB();
  }

  void insertItemQuick({required Drink drink}) async {
    await CartDatabase.insertRecord(
        cartItem: CartItem(drink: drink, milkAmount: 50, size: 1, quantity: 1));
    getCartItemsFromDB();
  }

  void insertItem({required CartItem cartItem}) async {
    await CartDatabase.insertRecord(cartItem: cartItem);
    getCartItemsFromDB();
  }

  void deleteDB() async {
    await CartDatabase.deleteDB();
    getCartItemsFromDB();
  }
}
