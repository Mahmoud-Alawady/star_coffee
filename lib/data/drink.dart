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
  factory Drink.dump0() {
    return Drink(
        image:
            'https://images.unsplash.com/photo-1542990253-0d0f5be5f0ed?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aG90JTIwY2hvY29sYXRlfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60',
        title: 'Hot Chocolate',
        subtitle: 'With Milk',
        price: 10.5,
        rate: 4.5);
  }
  factory Drink.dump1() {
    return Drink(
        image:
            'https://images.unsplash.com/photo-1541167760496-1628856ab772?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1037&q=80',
        title: 'Coffee',
        subtitle: 'no Milk',
        price: 8.5,
        rate: 4.0);
  }
  factory Drink.dump2() {
    return Drink(
        image:
            'https://media.istockphoto.com/id/466073662/photo/tea-cup-on-saucer-with-tea-being-poured.jpg?s=612x612&w=0&k=20&c=skmYl4zd-1Op_YF0pYVh2is4D6fakwK2LPFpRZRMB9U=',
        title: 'Tea',
        subtitle: 'black Tea',
        price: 5,
        rate: 4.8);
  }
  factory Drink.dump3() {
    return Drink(
        image:
            'https://images.unsplash.com/photo-1557142046-c704a3adf364?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8aG90JTIwY2hvY29sYXRlfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60',
        title: 'Hot Chocolate',
        subtitle: 'with cream',
        price: 5,
        rate: 4.8);
  }
  factory Drink.dump4() {
    return Drink(
        image:
            'https://images.unsplash.com/photo-1557142046-c704a3adf364?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8aG90JTIwY2hvY29sYXRlfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60',
        title: 'Choco Milk',
        subtitle: 'chocolate milk',
        price: 5,
        rate: 4.8);
  }
}
