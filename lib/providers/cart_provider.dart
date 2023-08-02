import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:star_coffee/bussiness/price_summary_calc.dart';
import 'package:star_coffee/data/drink.dart';
import '../data/cart_item.dart';
import '../data/price_summary_model.dart';

// enum CartState { initial, loaded, error }

class CartProvider with ChangeNotifier {
  var box;
  bool _itemsLoaded = false;
  bool _editMode = false;
  List<CartItem> _itemsList = [];

  bool get itemsLoaded => _itemsLoaded;

  List<CartItem> get cartItems => _itemsList;

  int get cartItemsCount => _itemsList.length;

  PriceSummaryModel get priceSummary =>
      PriceSummaryCalc.getPriceSummary(_itemsList);

  void getItems() async {
    if (!Hive.isBoxOpen('cartBox')) {
      box = await Hive.openBox<CartItem>('cartBox');
    }
    _itemsList = box.values.toList();
    _itemsLoaded = true;
    notifyListeners();
  }

  void addItem({required CartItem item}) async {
    if (!Hive.isBoxOpen('cartBox')) {
      box = await Hive.openBox<CartItem>('cartBox');
    }
    await box.add(item);
    getItems();
  }

  void addItemQuick({required Drink drink}) async {
    if (!Hive.isBoxOpen('cartBox')) {
      box = await Hive.openBox<CartItem>('cartBox');
    }
    await box.add(CartItem(drink: drink, milkAmount: 50, size: 1, quantity: 1));
    getItems();
  }

  void editCartItem({required CartItem cartItem, required int index}) async {
    if (!Hive.isBoxOpen('cartBox')) {
      box = await Hive.openBox<CartItem>('cartBox');
    }
    box.putAt(index, cartItem);
    getItems();
  }

  void deleteDB() async {
    if (!Hive.isBoxOpen('cartBox')) {
      box = await Hive.openBox<CartItem>('cartBox');
    }
    box.clear();
    getItems();
  }

  set editMode(bool isEnabled) {
    _editMode = isEnabled;
    notifyListeners();
  }
}
