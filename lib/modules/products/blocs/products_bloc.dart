import 'dart:async';
import 'package:e_commerce/data/constants/color_constants.dart';
import 'package:e_commerce/data/constants/filter_constants.dart';
import 'package:e_commerce/data/models/product.dart';
import 'package:e_commerce/data/models/sort.dart';
import 'package:e_commerce/modules/products/blocs/categories_bloc.dart';
import 'package:e_commerce/modules/products/widgets/filter_modal.dart';
import 'package:e_commerce/utils/services/api_service.dart';
import 'package:e_commerce/utils/bloc/bloc_base.dart';
import 'package:flutter/material.dart';

class ProductsBloc implements BlocBase {
  List<Product> _products = [];
  List<Product> get products => _products;
  final StreamController<List<Product>> _productsController =
      StreamController<List<Product>>();
  StreamSink<List<Product>> get _productsSink => _productsController.sink;
  Stream<List<Product>> get productsStream => _productsController.stream;

  Sort _sort = FilterConstants.priceSorting.first;
  Sort get sort => _sort;
  final StreamController<Sort> _sortController = StreamController<Sort>();
  StreamSink<Sort> get _sortSink => _sortController.sink;
  Stream<Sort> get sortStream => _sortController.stream;

  Sort _filterSort = FilterConstants.priceSorting.first;
  Sort get filterSort => _filterSort;
  final StreamController<Sort> _filterSortController =
      StreamController<Sort>.broadcast();
  StreamSink<Sort> get _filterSortSink => _filterSortController.sink;
  Stream<Sort> get filterSortStream => _filterSortController.stream;

  int _limit = FilterConstants.resultNumbers.first;
  int get limit => _limit;
  final StreamController<int> _limitController = StreamController<int>();
  StreamSink<int> get _limitSink => _limitController.sink;
  Stream<int> get limitStream => _limitController.stream;

  int _filterLimit = FilterConstants.resultNumbers.first;
  int get filterLimit => _filterLimit;
  final StreamController<int> _filterLimitController =
      StreamController<int>.broadcast();
  StreamSink<int> get _filterLimitSink => _filterLimitController.sink;
  Stream<int> get filterLimitStream => _filterLimitController.stream;

  String _search = '';
  String get search => _search;
  final StreamController<String> _searchController =
      StreamController<String>.broadcast();
  StreamSink<String> get _searchSink => _searchController.sink;
  Stream<String> get searchStream => _searchController.stream;

  ProductsBloc() {
    _productsSink.add(_products);
    _sortSink.add(_sort);
    _filterSortSink.add(_filterSort);
    _limitSink.add(_limit);
    _filterLimitSink.add(_filterLimit);
    _searchSink.add(_search);
  }

  void getProducts(CategoriesBloc categoriesBloc) async {
    _products = await ApiService.fetchProducts(
        categoriesBloc.selectedCategory, limit, sort);
    _productsSink.add(_products);
  }

  void onSortChanged(Sort newSort) {
    _sort = newSort;
    _sortSink.add(_sort);
  }

  void onFilterSortChanged(Sort newSort) {
    _filterSort = newSort;
    _filterSortSink.add(_filterSort);
  }

  void onLimitChanged(int newLimit) {
    _limit = newLimit;
    _limitSink.add(_limit);
  }

  void onFilterLimitChanged(int newLimit) {
    _filterLimit = newLimit;
    _filterLimitSink.add(_filterLimit);
  }

  void onSearchChanged(String input) {
    _search = input;
    _searchSink.add(_search);
  }

  void onFilterPressed(BuildContext context, CategoriesBloc categoriesBloc) {
    categoriesBloc.onFilterCategoryChanged(categoriesBloc.selectedCategory);
    onFilterSortChanged(sort);
    onFilterLimitChanged(limit);
    onModalCalled(
      context,
      FilterModal(categoriesBloc: categoriesBloc, productsBloc: this),
    );
  }

  onCancelFilterPressed(BuildContext context, CategoriesBloc categoriesBloc) {
    categoriesBloc.onFilterCategoryChanged(categoriesBloc.selectedCategory);
    onFilterSortChanged(sort);
    onFilterLimitChanged(limit);
    Navigator.of(context).pop();
  }

  onApplyFilterPressed(BuildContext context, CategoriesBloc categoriesBloc) {
    onSortChanged(filterSort);
    onLimitChanged(filterLimit);
    categoriesBloc.onCategoryChanged(categoriesBloc.filterCategory, this);
    Navigator.of(context).pop();
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

  @override
  void dispose() {
    _productsController.close();
    _limitController.close();
    _searchController.close();
  }
}

// final ProductsBloc productsBloc = ProductsBloc();
