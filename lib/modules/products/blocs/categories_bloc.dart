import 'dart:async';
import 'package:e_commerce/modules/products/blocs/products_bloc.dart';
import 'package:e_commerce/utils/services/api_service.dart';
import 'package:e_commerce/utils/bloc/bloc_base.dart';

class CategoriesBloc implements BlocBase {
  List<String> _categories = [];
  List<String> get categories => _categories;
  final StreamController<List<String>> _categoriesController =
      StreamController<List<String>>.broadcast();
  StreamSink<List<String>> get _categoriesSink => _categoriesController.sink;
  Stream<List<String>> get categoriesStream => _categoriesController.stream;

  String _selectedCategory = 'All';
  String get selectedCategory => _selectedCategory;
  final StreamController<String> _selectedCategoryController =
      StreamController<String>.broadcast();
  StreamSink<String> get _selectedCategorySink =>
      _selectedCategoryController.sink;
  Stream<String> get selectedCategoryStream =>
      _selectedCategoryController.stream;

  String _filterCategory = 'All';
  String get filterCategory => _filterCategory;
  final StreamController<String> _filterCategoryController =
      StreamController<String>.broadcast();
  StreamSink<String> get _filterCategorySink => _filterCategoryController.sink;
  Stream<String> get filterCategoryStream => _filterCategoryController.stream;

  CategoriesBloc() {
    _categoriesSink.add(_categories);
    _selectedCategorySink.add(_selectedCategory);
    _filterCategorySink.add(_filterCategory);
  }

  void getCategories(ProductsBloc productsBloc) async {
    _categories = await ApiService.fetchCategories();
    productsBloc.getProducts(this);
    _categoriesSink.add(_categories);
  }

  void onCategoryChanged(String category, ProductsBloc productsBloc) {
    _selectedCategory = category;
    _selectedCategorySink.add(_selectedCategory);
    onFilterCategoryChanged(category);
    productsBloc.getProducts(this);
  }

  void onFilterCategoryChanged(String category) {
    _filterCategory = category;
    _filterCategorySink.add(_filterCategory);
  }

  @override
  void dispose() {
    _categoriesController.close();
    _selectedCategoryController.close();
  }
}

// final CategoriesBloc categoriesBloc = CategoriesBloc();
