import 'package:flutter_start/models/product.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductService {
  static const String _baseUrl = 'https://dummyjson.com';

  static Future<List<Product>> getProducts() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/products?limit=20'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);  
      final List productsJson = data['products'];  
      return productsJson.map((p) => Product.fromJson(p)).toList();
    }

    throw Exception('Failed to load products');
  }

  // Search products by a query string
  static Future<List<Product>> searchProducts(String query) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/products/search?q=$query'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List productsJson = data['products'];
      return productsJson.map((p) => Product.fromJson(p)).toList();
    }

    throw Exception('Failed to search products');
  }
  
}
