import 'dart:async';
import 'package:e_commerce/modules/products/blocs/products_bloc.dart';
import 'package:e_commerce/utils/services/api_service.dart';

class CategoriesBloc {
  List<String> _categories = [];
  List<String> get categories => _categories;

  String _selectedCategory = 'All';
  String get selectedCategory => _selectedCategory;

  final StreamController<List<String>> _categoriesController =
      StreamController<List<String>>();
  StreamSink<List<String>> get _categoriesSink => _categoriesController.sink;
  Stream<List<String>> get categoriesStream => _categoriesController.stream;

  final StreamController<String> _selectedCategoryController =
      StreamController<String>.broadcast();
  StreamSink<String> get _selectedCategorySink =>
      _selectedCategoryController.sink;
  Stream<String> get selectedCategoryStream =>
      _selectedCategoryController.stream;

  CategoriesBloc() {
    _categoriesSink.add(_categories);
    _selectedCategorySink.add(_selectedCategory);
  }

  void getCategories() async {
    _categories = await ApiService.fetchCategories();
    productsBloc.getProducts();
    _categoriesSink.add(_categories);
  }

  void onCategoryChanged(String category) {
    _selectedCategory = category;
    _selectedCategorySink.add(_selectedCategory);
    productsBloc.getProducts();
  }
}

final CategoriesBloc categoriesBloc = CategoriesBloc();
