import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:star_coffee/bussiness/price_summary_calc.dart';
import 'package:star_coffee/data/drink.dart';
import '../data/cart_item.dart';
import '../data/price_summary_model.dart';

class CartProvider with ChangeNotifier {
  late Box<CartItem> box;
  bool _itemsLoaded = false;
  bool _editMode = false;
  List<CartItem> _itemsList = [];
  final List<int> _selectedItems = [];

  bool get itemsLoaded => _itemsLoaded;

  bool get editMode => _editMode;

  List<CartItem> get cartItems => _itemsList;

  List<int> get selectedItems => _selectedItems;

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

  void toggleEditMode() {
    if (_editMode) {
      _editMode = false;
    } else {
      _editMode = true;
    }
    notifyListeners();
  }

  void addToSelected(int index) {
    _selectedItems.add(index);
    notifyListeners();
  }

  void removeFromSelected(int index) {
    _selectedItems.remove(index);
    notifyListeners();
  }

  void deleteSelected() async {
    if (!Hive.isBoxOpen('cartBox')) {
      box = await Hive.openBox<CartItem>('cartBox');
    }

    _selectedItems.sort();
    for (int i = _selectedItems.length - 1; i > -1; i--) {
      await box.deleteAt(_selectedItems[i]);
    }

    _selectedItems.clear();
    _editMode = false;
    getItems();
  }
}
