import 'drink.dart';

class CartItem {
  int? id;
  Drink drink;
  int milkAmount;
  int size;
  int quantity;

  CartItem({
    this.id,
    required this.drink,
    required this.milkAmount,
    required this.size,
    required this.quantity,
  });

  factory CartItem.fromDB(Map<dynamic, dynamic> cartItem) {
    return CartItem(
        id: cartItem['id'],
        drink: Drink(
            image: cartItem['image'],
            title: cartItem['title'],
            subtitle: cartItem['subtitle'],
            price: cartItem['price'],
            rate: cartItem['rate']),
        milkAmount: cartItem['milkAmount'],
        size: cartItem['size'],
        quantity: cartItem['quantity']);
  }

  // factory CartItem.fromJson(Map<String, dynamic> json) {
  //   return CartItem(
  //     id: json['id'],
  //     drink: json['drink'],
  //     milkAmount: json['milk_amount'],
  //     size: json['size'],
  //     quantity: json['quantity'],
  //   );
  // }
}
