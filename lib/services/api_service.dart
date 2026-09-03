import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_start/components/product.dart';

class ApiService {
  // Using the reliable FakeStoreAPI for prototyping
  static const String _baseUrl = 'https://fakestoreapi.com';
  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl), headers: {"Accept": "application/json"});

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        // Map the dynamic JSON list into a strongly-typed list of Product models
        return body.map((dynamic item) => Product.fromJson(item)).toList();
      } else {
        throw Exception(
          'Failed to load products: Server returned code ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Network error occurred: $e');
    }
  }
}
