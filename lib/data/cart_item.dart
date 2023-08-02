import 'package:hive/hive.dart';
import 'drink.dart';

part 'cart_item.g.dart';

@HiveType(typeId: 1)
class CartItem {
  @HiveField(1)
  Drink drink;

  @HiveField(2)
  int milkAmount;

  @HiveField(3)
  int size;

  @HiveField(0)
  int quantity;

  CartItem({
    required this.drink,
    required this.milkAmount,
    required this.size,
    required this.quantity,
  });

  factory CartItem.fromDB(Map<dynamic, dynamic> cartItem) {
    return CartItem(
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
