import 'dart:async';
import 'package:e_commerce/data/constants/filter_constants.dart';
import 'package:e_commerce/data/models/sort.dart';
import 'package:e_commerce/modules/products/blocs/products_bloc.dart';
import 'package:e_commerce/utils/services/api_service.dart';
import 'package:e_commerce/utils/bloc/bloc_base.dart';
import 'package:flutter/material.dart';

class FilterBloc implements BlocBase {
  bool _loading = true;
  bool get loading => _loading;
  final StreamController<bool> _loadingController = StreamController<bool>();
  StreamSink<bool> get _loadingSink => _loadingController.sink;
  Stream<bool> get loadingStream => _loadingController.stream;

  List<String> _categories = [];
  List<String> get categories => _categories;
  final StreamController<List<String>> _categoriesController =
      StreamController<List<String>>.broadcast();
  StreamSink<List<String>> get _categoriesSink => _categoriesController.sink;
  Stream<List<String>> get categoriesStream => _categoriesController.stream;

  String _filterCategory = 'All';
  String get filterCategory => _filterCategory;
  final StreamController<String> _filterCategoryController =
      StreamController<String>.broadcast();
  StreamSink<String> get _filterCategorySink => _filterCategoryController.sink;
  Stream<String> get filterCategoryStream => _filterCategoryController.stream;

  Sort _filterSort = FilterConstants.priceSorting.first;
  Sort get filterSort => _filterSort;
  final StreamController<Sort> _filterSortController =
      StreamController<Sort>.broadcast();
  StreamSink<Sort> get _filterSortSink => _filterSortController.sink;
  Stream<Sort> get filterSortStream => _filterSortController.stream;

  int _filterLimit = FilterConstants.resultNumbers.first;
  int get filterLimit => _filterLimit;
  final StreamController<int> _filterLimitController =
      StreamController<int>.broadcast();
  StreamSink<int> get _filterLimitSink => _filterLimitController.sink;
  Stream<int> get filterLimitStream => _filterLimitController.stream;

  CategoriesBloc() {
    _loadingSink.add(_loading);
    _categoriesSink.add(_categories);
    _filterCategorySink.add(_filterCategory);
    _filterSortSink.add(_filterSort);
    _filterLimitSink.add(_filterLimit);
  }

  void getCategories(ProductsBloc productsBloc) async {
    _loading = true;
    _loadingSink.add(_loading);
    _categories = await ApiService.fetchCategories();
    _categoriesSink.add(_categories);
    _loading = false;
    _loadingSink.add(_loading);
    productsBloc.getProducts();
  }

  void onFilterCategoryChanged(String category) {
    _filterCategory = category;
    _filterCategorySink.add(_filterCategory);
  }

  void onFilterSortChanged(Sort newSort) {
    _filterSort = newSort;
    _filterSortSink.add(_filterSort);
  }

  void onFilterLimitChanged(int newLimit) {
    _filterLimit = newLimit;
    _filterLimitSink.add(_filterLimit);
  }

  onCancelFilterPressed(BuildContext context, ProductsBloc productsBloc) {
    onFilterCategoryChanged(productsBloc.selectedCategory);
    onFilterSortChanged(productsBloc.sort);
    onFilterLimitChanged(productsBloc.limit);
    Navigator.of(context).pop();
  }

  onApplyFilterPressed(BuildContext context, ProductsBloc productsBloc) {
    productsBloc.onSortChanged(filterSort);
    productsBloc.onLimitChanged(filterLimit);
    productsBloc.onCategoryChanged(filterCategory, this);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _loadingController.close();
    _categoriesController.close();
    _filterCategoryController.close();
    _filterSortController.close();
  }
}
