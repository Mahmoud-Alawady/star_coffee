import 'drink.dart';

class CartItem {
  Drink drink;
  double milkAmount;
  int size;
  int quantity;

  CartItem({
    required this.drink,
    required this.milkAmount,
    required this.size,
    required this.quantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      drink: json['drink'],
      milkAmount: json['milk_amount'],
      size: json['size'],
      quantity: json['quantity'],
    );
  }
}
