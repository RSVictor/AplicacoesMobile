class Food {
  final int id;
  final String name;
  final double price;
  final String category;

  Food({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['id'],
      name: json['name'],
      price: double.parse(json['price'].toString()),
      category: json['category'],
    );
  }
}
