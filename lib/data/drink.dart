class Drink {
  String image;
  String title;
  String subtitle;
  double price;
  double rate;

  Drink({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.rate,
  });

  factory Drink.fromJson(Map<String, dynamic> json) {
    return Drink(
        image: json['image'],
        title: json['title'],
        subtitle: json['subtitle'],
        price: json['price'],
        rate: json['rate']);
  }
  factory Drink.dump() {
    return Drink(
        image:
            'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSTYxivH20FB9dAZBtEHhlZ04EFG5-c6I8p-pP7rOShQrfeUxvk',
        title: 'Cappuccino',
        subtitle: 'With Milk',
        price: 10.5,
        rate: 4.5);
  }
}
