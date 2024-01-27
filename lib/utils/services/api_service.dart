import 'dart:convert';
import 'package:e_commerce/data/constants/endpoints.dart';
import 'package:e_commerce/data/models/product.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<Product>> fetchProducts(String category, int limit) async {
    List<Product> mappedProducts = [];
    String url = Endpoints.baseUrl +
        Endpoints.products +
        Endpoints.setUrlParameters([
          {'key': 'limit', 'value': limit}
        ]);
    if (category != 'All') {
      url = Endpoints.baseUrl +
          Endpoints.productsByCategory +
          category +
          Endpoints.setUrlParameters([
            {'key': 'limit', 'value': limit}
          ]);
    }

    print(url);

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> categories = json.decode(response.body);
        mappedProducts = categories.map((e) => Product.fromJson(e)).toList();
      } else {
        // TODO - DISPLAYING ERROR MESSAGE
        if (kDebugMode) {
          print('GET POSTS ERROR WITH CODE: ${response.statusCode}');
        }
      }
    } catch (e) {
      // TODO - DISPLAYING ERROR MESSAGE
      if (kDebugMode) {
        print('GET POSTS ERROR: $e');
        rethrow;
      }
    }

    return mappedProducts;
  }

  static Future<List<String>> fetchCategories() async {
    List<String> mappedCategories = [];
    try {
      final response = await http
          .get(Uri.parse(Endpoints.baseUrl + Endpoints.productCategories));
      if (response.statusCode == 200) {
        final List<dynamic> categories = json.decode(response.body);
        mappedCategories = categories.map((e) => e.toString()).toList();
        mappedCategories.insert(0, 'All');
      } else {
        // TODO - DISPLAYING ERROR MESSAGE
        if (kDebugMode) {
          print('GET POSTS ERROR WITH CODE: ${response.statusCode}');
        }
      }
    } catch (e) {
      // TODO - DISPLAYING ERROR MESSAGE
      if (kDebugMode) {
        print('GET POSTS ERROR: $e');
        rethrow;
      }
    }

    return mappedCategories;
  }
}
