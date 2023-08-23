import 'package:star_coffee/data/price_summary_model.dart';
import '../data/cart_item.dart';

abstract class PriceSummaryCalc {
  static PriceSummaryModel getPriceSummary(List<CartItem> items) {
    if (items.isEmpty) {
      PriceSummaryModel p = PriceSummaryModel(0);
      p.total = 0;
      return p;
    } else {
      double subtotal = 0;
      for (int i = 0; i < items.length; i++) {
        subtotal += items[i].drink.price * items[i].quantity;
      }
      return PriceSummaryModel(subtotal);
    }
  }
}
