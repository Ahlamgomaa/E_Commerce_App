import 'dart:convert';
import 'package:e_commerce_app/models/product.dart';
import 'package:http/http.dart' as http;

class ProductRepository {
  final http.Client httpClient;

  ProductRepository({http.Client? httpClient})
    : httpClient = httpClient ?? http.Client(); //DI

  Future<List<Product>> fetchProducts() async {
    final uri = Uri.parse('https://fakestoreapi.com/products');
    final resp = await httpClient.get(uri).timeout(const Duration(seconds: 10));
    if (resp.statusCode != 200) {
      throw Exception('Failed to load products(code:{${resp.statusCode}})');
    }
    final list = jsonDecode(resp.body) as List<dynamic>;
    return list
        .map((e) => Product.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<Product> fetchProduct(int id) async {
    final uri = Uri.parse('https://fakestoreapi.com/products/$id');
    final resp = await httpClient.get(uri).timeout(const Duration(seconds: 10));
    if (resp.statusCode != 200) {
      throw Exception('Failed to load product(code:{${resp.statusCode}})');
    }
    final map = jsonDecode(resp.body) as Map<String, dynamic>;
    return Product.fromJson(map);
  }
}

