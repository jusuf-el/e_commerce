import 'dart:async';
import 'package:e_commerce/data/models/product.dart';
import 'package:e_commerce/modules/product_details/widgets/edit_product_modal.dart';
import 'package:e_commerce/utils/services/api_service.dart';
import 'package:e_commerce/utils/bloc/bloc_base.dart';
import 'package:e_commerce/utils/services/modal_service.dart';
import 'package:flutter/cupertino.dart';

class ProductDetailsBloc implements BlocBase {
  Product _product = Product();
  Product get product => _product;
  final StreamController<Product> _productController =
      StreamController<Product>.broadcast();
  StreamSink<Product> get _productSink => _productController.sink;
  Stream<Product> get productStream => _productController.stream;

  Product _editProduct = Product();
  Product get editProduct => _product;
  final StreamController<Product> _editProductController =
      StreamController<Product>.broadcast();
  StreamSink<Product> get _editProductSink => _editProductController.sink;
  Stream<Product> get editProductStream => _editProductController.stream;

  bool _loading = true;
  bool get loading => _loading;
  final StreamController<bool> _loadingController = StreamController<bool>();
  StreamSink<bool> get _loadingSink => _loadingController.sink;
  Stream<bool> get loadingStream => _loadingController.stream;

  ProductDetailsBloc() {
    _productSink.add(_product);
    _editProductSink.add(_editProduct);
    _loadingSink.add(_loading);
  }

  void getProduct(BuildContext context, int? productId,
      {bool openEdit = false, Function()? openEditCallback}) async {
    if (productId != null) {
      _loading = true;
      _loadingSink.add(_loading);
      _product = await ApiService.fetchProductById(context, productId);
      _productSink.add(_product);
      _loading = false;
      _loadingSink.add(_loading);

      if (openEdit && openEditCallback != null) {
        openEditCallback();
      }
    }
  }

  onEditProductChanged(Product newProduct) {
    _editProduct = newProduct;
    _editProductSink.add(_editProduct);
  }

  onEditCategoryChanged(String newCategory) {
    _editProduct = editProduct.copyWith(category: newCategory);
    _editProductSink.add(_editProduct);
  }

  onEditTitleChanged(String newTitle) {
    _editProduct = editProduct.copyWith(title: newTitle);
    _editProductSink.add(_editProduct);
  }

  onEditPriceChanged(String newPrice) {
    _editProduct = editProduct.copyWith(price: newPrice);
    _editProductSink.add(_editProduct);
  }

  onEditDescriptionChanged(String newDescription) {
    _editProduct = editProduct.copyWith(description: newDescription);
    _editProductSink.add(_editProduct);
  }

  onEditProductPressed(
    BuildContext context,
    Product product,
    Function(Product) callback,
    TextEditingController titleEditingController,
    priceEditingController,
    descriptionEditingController,
    List<String> categories,
  ) {
    callback(product);
    onEditCategoryChanged(product.category);
    ModalService.openModal(
      context,
      EditProductModal(
        product: product,
        titleEditingController: titleEditingController,
        priceEditingController: priceEditingController,
        descriptionEditingController: descriptionEditingController,
        categories: categories,
        onSavePressed: onSaveEditPressed,
        productDetailsBloc: this,
        onCategoryChanged: onEditCategoryChanged,
      ),
    );
  }

  onSaveEditPressed(
      BuildContext context, Product product, Product editProduct) async {
    await ApiService.updateProduct(context, product.id!, editProduct);
    if (context.mounted) {
      Navigator.of(context).pop();
    }
    _loading = true;
    _loadingSink.add(_loading);
    if (context.mounted) {
      getProduct(context, product.id);
    }
  }

  bool isSaveEnabled(Product product, Product editProduct) =>
      product.title != editProduct.title ||
      product.price != editProduct.price ||
      product.category != editProduct.category ||
      product.description != editProduct.description;

  @override
  void dispose() {
    _productController.close();
    _editProductController.close();
    _loadingController.close();
  }
}
