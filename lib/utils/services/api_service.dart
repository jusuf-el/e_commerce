import 'dart:convert';
import 'package:e_commerce/data/constants/endpoints.dart';
import 'package:e_commerce/data/models/product.dart';
import 'package:e_commerce/data/models/sort.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<Product>> fetchProducts(
      String category, int limit, Sort sort) async {
    List<Product> mappedProducts = [];
    String url = Endpoints.baseUrl +
        Endpoints.products +
        Endpoints.setUrlParameters([
          {'key': 'limit', 'value': limit},
          {'key': 'sort', 'value': sort.value},
        ]);
    if (category != 'All') {
      url = Endpoints.baseUrl +
          Endpoints.productsByCategory +
          category +
          Endpoints.setUrlParameters([
            {'key': 'limit', 'value': limit},
            {'key': 'sort', 'value': sort.value},
          ]);
    }

    print(url);

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> products = json.decode(response.body);
        mappedProducts = products.map((e) => Product.fromJson(e)).toList();
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

  static Future<Product> fetchProductById(int id) async {
    Product mappedProduct = Product();
    String url = '${Endpoints.baseUrl}${Endpoints.products}/$id';

    print(url);

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        mappedProduct = Product.fromJson(json.decode(response.body));
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

    return mappedProduct;
  }

  static Future<Product> deleteProduct(int id) async {
    Product mappedProduct = Product();
    String url = '${Endpoints.baseUrl}${Endpoints.products}/$id';

    print(url);

    try {
      final response = await http.delete(Uri.parse(url));
      if (response.statusCode == 200) {
        mappedProduct = Product.fromJson(json.decode(response.body));
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

    return mappedProduct;
  }

  static Future<List<String>> fetchCategories() async {
    List<String> mappedCategories = [];

    String url = Endpoints.baseUrl + Endpoints.productCategories;

    print(url);

    try {
      final response = await http.get(Uri.parse(url));
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
