class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String thumbnail; // image URL
  final double rating;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.thumbnail,
    required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: _asInt(json['id']),
      title: _asString(json['title']),
      price: _asDouble(json['price']),
      description: _asString(json['description']),
      category: _asString(json['category']),
      thumbnail: _asString(json['thumbnail']),
      rating: _asDouble(json['rating']),
    );
  }

  static int _asInt(dynamic value) => value is num ? value.toInt() : 0;

  static double _asDouble(dynamic value) => value is num ? value.toDouble() : 0;

  static String _asString(dynamic value) => value is String ? value : '';
}
