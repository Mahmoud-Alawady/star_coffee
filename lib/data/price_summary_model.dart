class PriceSummaryModel {
  double subtotal = 0;
  double total = 0;
  double shippingCost = 1;
  double taxes = 1;

  PriceSummaryModel(this.subtotal) {
    total = subtotal + shippingCost + taxes;
  }
}
