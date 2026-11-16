class Product {
  final String name;
  final String category;
  final String price;
  final String image;
  final String description;

  bool isFavorite;

  Product({
    required this.name,
    required this.category,
    required this.price,
    required this.image,
    required this.description,
    this.isFavorite = false,
  });
}