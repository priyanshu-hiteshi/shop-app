// services/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ApiService {
  final String baseUrl = "https://dummyjson.com/products";

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        // Check if the response contains the 'products' key and if it's not null
        Map<String, dynamic> data = jsonDecode(response.body);
        if (data['products'] != null) {
          List<dynamic> productsData = data['products'];
          return productsData.map((item) => Product.fromJson(item)).toList();
        } else {
          throw Exception('No products found in the response');
        }
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }
}
