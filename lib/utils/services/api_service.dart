import 'dart:convert';
import 'package:e_commerce/data/constants/endpoints.dart';
import 'package:e_commerce/data/constants/filter_constants.dart';
import 'package:e_commerce/data/constants/strings.dart';
import 'package:e_commerce/data/models/product.dart';
import 'package:e_commerce/data/models/sort.dart';
import 'package:e_commerce/utils/services/notify_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<Product>> fetchProducts(
      BuildContext context, String category, int limit, Sort sort) async {
    List<Product> mappedProducts = [];
    String url = Endpoints.baseUrl +
        Endpoints.products +
        Endpoints.setUrlParameters([
          {'key': 'limit', 'value': limit},
          {'key': 'sort', 'value': sort.value},
        ]);
    if (category != FilterConstants.defaultCategory) {
      url = Endpoints.baseUrl +
          Endpoints.productsByCategory +
          category +
          Endpoints.setUrlParameters([
            {'key': 'limit', 'value': limit},
            {'key': 'sort', 'value': sort.value},
          ]);
    }

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> products = json.decode(response.body);
        mappedProducts = products.map((e) => Product.fromJson(e)).toList();
      } else {
        if (context.mounted) {
          NotifyService.showErrorMessage(context, Strings.productsError);
        }
      }
    } catch (e) {
      if (context.mounted) {
        NotifyService.showErrorMessage(context, Strings.productsError);
      }
      if (kDebugMode) {
        rethrow;
      }
    }

    return mappedProducts;
  }

  static Future<Product> fetchProductById(BuildContext context, int id) async {
    Product mappedProduct = Product();
    String url = '${Endpoints.baseUrl}${Endpoints.products}/$id';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        mappedProduct = Product.fromJson(json.decode(response.body));
      } else {
        if (context.mounted) {
          NotifyService.showErrorMessage(context, Strings.productError);
        }
      }
    } catch (e) {
      if (context.mounted) {
        NotifyService.showErrorMessage(context, Strings.productError);
      }
      if (kDebugMode) {
        rethrow;
      }
    }

    return mappedProduct;
  }

  static Future<Product> deleteProduct(BuildContext context, int id) async {
    Product mappedProduct = Product();
    String url = '${Endpoints.baseUrl}${Endpoints.products}/$id';

    try {
      final response = await http.delete(Uri.parse(url));
      if (response.statusCode == 200) {
        mappedProduct = Product.fromJson(json.decode(response.body));
        if (context.mounted) {
          NotifyService.showSuccessMessage(context, Strings.productDeleted);
        }
      } else {
        if (context.mounted) {
          NotifyService.showErrorMessage(context, Strings.productDeleteError);
        }
      }
    } catch (e) {
      if (context.mounted) {
        NotifyService.showErrorMessage(context, Strings.productDeleteError);
      }
      if (kDebugMode) {
        rethrow;
      }
    }

    return mappedProduct;
  }

  static Future<Product> updateProduct(
      BuildContext context, int id, Product product) async {
    Product mappedProduct = Product();
    String url = '${Endpoints.baseUrl}${Endpoints.products}/$id';

    try {
      final response =
          await http.patch(Uri.parse(url), body: jsonEncode(product));
      if (response.statusCode == 200) {
        mappedProduct = Product.fromJson(json.decode(response.body));
        if (context.mounted) {
          NotifyService.showSuccessMessage(context, Strings.productUpdated);
        }
      } else {
        if (context.mounted) {
          NotifyService.showErrorMessage(context, Strings.productUpdateError);
        }
      }
    } catch (e) {
      if (context.mounted) {
        NotifyService.showErrorMessage(context, Strings.productUpdateError);
      }
      if (kDebugMode) {
        rethrow;
      }
    }

    return mappedProduct;
  }

  static Future<List<String>> fetchCategories(BuildContext context) async {
    List<String> mappedCategories = [];
    String url = Endpoints.baseUrl + Endpoints.productCategories;

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> categories = json.decode(response.body);
        mappedCategories = categories.map((e) => e.toString()).toList();
        mappedCategories.insert(0, FilterConstants.defaultCategory);
      } else {
        if (context.mounted) {
          NotifyService.showErrorMessage(context, Strings.categoriesError);
        }
      }
    } catch (e) {
      if (context.mounted) {
        NotifyService.showErrorMessage(context, Strings.categoriesError);
      }
      if (kDebugMode) {
        rethrow;
      }
    }

    return mappedCategories;
  }
}
