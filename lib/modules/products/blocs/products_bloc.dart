import 'dart:async';
import 'package:e_commerce/data/constants/color_constants.dart';
import 'package:e_commerce/data/constants/filter_constants.dart';
import 'package:e_commerce/data/models/product.dart';
import 'package:e_commerce/data/models/sort.dart';
import 'package:e_commerce/modules/products/blocs/filter_bloc.dart';
import 'package:e_commerce/modules/products/widgets/filter_modal.dart';
import 'package:e_commerce/utils/services/api_service.dart';
import 'package:e_commerce/utils/bloc/bloc_base.dart';
import 'package:flutter/material.dart';

class ProductsBloc implements BlocBase {
  bool _loading = true;
  bool get loading => _loading;
  final StreamController<bool> _loadingController = StreamController<bool>();
  StreamSink<bool> get _loadingSink => _loadingController.sink;
  Stream<bool> get loadingStream => _loadingController.stream;

  List<Product> _products = [];
  List<Product> get products => _products;
  final StreamController<List<Product>> _productsController =
      StreamController<List<Product>>.broadcast();
  StreamSink<List<Product>> get _productsSink => _productsController.sink;
  Stream<List<Product>> get productsStream => _productsController.stream;

  String _selectedCategory = 'All';
  String get selectedCategory => _selectedCategory;
  final StreamController<String> _selectedCategoryController =
      StreamController<String>.broadcast();
  StreamSink<String> get _selectedCategorySink =>
      _selectedCategoryController.sink;
  Stream<String> get selectedCategoryStream =>
      _selectedCategoryController.stream;

  Sort _sort = FilterConstants.priceSorting.first;
  Sort get sort => _sort;
  final StreamController<Sort> _sortController = StreamController<Sort>();
  StreamSink<Sort> get _sortSink => _sortController.sink;
  Stream<Sort> get sortStream => _sortController.stream;

  int _limit = FilterConstants.resultNumbers.first;
  int get limit => _limit;
  final StreamController<int> _limitController = StreamController<int>();
  StreamSink<int> get _limitSink => _limitController.sink;
  Stream<int> get limitStream => _limitController.stream;

  String _search = '';
  String get search => _search;
  final StreamController<String> _searchController =
      StreamController<String>.broadcast();
  StreamSink<String> get _searchSink => _searchController.sink;
  Stream<String> get searchStream => _searchController.stream;

  ProductsBloc() {
    _loadingSink.add(_loading);
    _productsSink.add(_products);
    _selectedCategorySink.add(_selectedCategory);
    _sortSink.add(_sort);
    _limitSink.add(_limit);
    _searchSink.add(_search);
  }

  void getProducts() async {
    _loading = true;
    _loadingSink.add(_loading);
    _products = await ApiService.fetchProducts(selectedCategory, limit, sort);
    _productsSink.add(_products);
    _loading = false;
    _loadingSink.add(_loading);
  }

  void onCategoryChanged(String category, FilterBloc filterBloc) {
    _selectedCategory = category;
    _selectedCategorySink.add(_selectedCategory);
    filterBloc.onFilterCategoryChanged(category);
    getProducts();
  }

  void onSortChanged(Sort newSort) {
    _sort = newSort;
    _sortSink.add(_sort);
  }

  void onLimitChanged(int newLimit) {
    _limit = newLimit;
    _limitSink.add(_limit);
  }

  void onSearchChanged(String input) {
    _search = input;
    _searchSink.add(_search);
  }

  void onFilterPressed(BuildContext context, FilterBloc filterBloc) {
    filterBloc.onFilterCategoryChanged(selectedCategory);
    filterBloc.onFilterSortChanged(sort);
    filterBloc.onFilterLimitChanged(limit);
    onModalCalled(
      context,
      FilterModal(filterBloc: filterBloc, productsBloc: this),
    );
  }

  void onModalCalled(BuildContext context, Widget child) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return child;
      },
      constraints: BoxConstraints(
        minWidth: double.infinity,
        maxHeight: MediaQuery.of(context).size.height,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        side: BorderSide.none,
      ),
      isScrollControlled: true,
      backgroundColor: ColorConstants.lightGrey,
    );
  }

  onDeleteProductPressed(BuildContext context, int? productId) async {
    if (productId != null) {
      await ApiService.deleteProduct(productId);
      if (context.mounted) {
        Navigator.of(context).pop();
      }
      getProducts();
    }
  }

  @override
  void dispose() {
    _productsController.close();
    _limitController.close();
    _searchController.close();
  }
}
