import 'dart:async';
import 'package:e_commerce/data/models/product.dart';
import 'package:e_commerce/modules/products/blocs/categories_bloc.dart';
import 'package:e_commerce/utils/services/api_service.dart';

class ProductsBloc {
  List<Product> _products = [];
  List<Product> get products => _products;
  final StreamController<List<Product>> _productsController =
      StreamController<List<Product>>();
  StreamSink<List<Product>> get _productsSink => _productsController.sink;
  Stream<List<Product>> get productsStream => _productsController.stream;

  int _limit = 10;
  int get limit => _limit;
  final StreamController<int> _limitController = StreamController<int>();
  StreamSink<int> get _limitSink => _limitController.sink;
  Stream<int> get limitStream => _limitController.stream;

  String _search = '';
  String get search => _search;
  final StreamController<String> _searchController = StreamController<String>();
  StreamSink<String> get _searchSink => _searchController.sink;
  Stream<String> get searchStream => _searchController.stream;

  ProductsBloc() {
    _productsSink.add(_products);
    _limitSink.add(_limit);
    _searchSink.add(_search);
  }

  void getProducts() async {
    _products =
        await ApiService.fetchProducts(categoriesBloc.selectedCategory, limit);
    _productsSink.add(_products);
  }

  void onLimitChanged(int newLimit) {
    _limit = newLimit;
    _limitSink.add(_limit);
    getProducts();
  }

  void onSearchChanged(String input) {
    _search = input;
    _searchSink.add(_search);
  }
}

final ProductsBloc productsBloc = ProductsBloc();
