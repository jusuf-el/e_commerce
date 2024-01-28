import 'dart:async';
import 'package:e_commerce/data/models/product.dart';
import 'package:e_commerce/utils/services/api_service.dart';
import 'package:e_commerce/utils/bloc/bloc_base.dart';

class ProductDetailsBloc implements BlocBase {
  Product _product = Product();
  Product get product => _product;
  final StreamController<Product> _productController =
      StreamController<Product>();
  StreamSink<Product> get _productSink => _productController.sink;
  Stream<Product> get productStream => _productController.stream;

  bool _loading = true;
  bool get loading => _loading;
  final StreamController<bool> _loadingController = StreamController<bool>();
  StreamSink<bool> get _loadingSink => _loadingController.sink;
  Stream<bool> get loadingStream => _loadingController.stream;

  ProductDetailsBloc() {
    _productSink.add(_product);
    _loadingSink.add(_loading);
  }

  void getProduct(int? productId) async {
    if (productId != null) {
      _loading = true;
      _loadingSink.add(_loading);
      _product = await ApiService.fetchProductById(productId);
      _productSink.add(_product);
      _loading = false;
      _loadingSink.add(_loading);
    }
  }

  @override
  void dispose() {
    _productController.close();
  }
}
