import 'package:e_commerce/data/constants/color_constants.dart';
import 'package:e_commerce/data/constants/filter_constants.dart';
import 'package:e_commerce/data/constants/strings.dart';
import 'package:e_commerce/data/models/product.dart';
import 'package:e_commerce/data/reusable_widgets/zen_divider.dart';
import 'package:e_commerce/data/reusable_widgets/zen_input_field.dart';
import 'package:e_commerce/data/reusable_widgets/zen_button.dart';
import 'package:e_commerce/data/reusable_widgets/zen_dropdown.dart';
import 'package:e_commerce/modules/product_details/blocs/product_details_bloc.dart';
import 'package:e_commerce/modules/product_details/widgets/product_gallery_image.dart';
import 'package:e_commerce/utils/services/modal_service.dart';
import 'package:flutter/material.dart';

class EditProductModal extends StatelessWidget {
  final Product product;
  final TextEditingController titleEditingController;
  final TextEditingController priceEditingController;
  final TextEditingController descriptionEditingController;
  final List<String> categories;
  final Function(BuildContext, Product, Product) onSavePressed;
  final ProductDetailsBloc productDetailsBloc;
  final Function(String) onCategoryChanged;

  const EditProductModal({
    super.key,
    required this.product,
    required this.titleEditingController,
    required this.priceEditingController,
    required this.descriptionEditingController,
    required this.categories,
    required this.onSavePressed,
    required this.productDetailsBloc,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Product>(
      stream: productDetailsBloc.editProductStream,
      initialData: productDetailsBloc.editProduct,
      builder:
          (BuildContext context, AsyncSnapshot<Product> editProductSnapshot) {
        Product editProduct = editProductSnapshot.data ?? Product();
        return StreamBuilder<Product>(
          stream: productDetailsBloc.productStream,
          initialData: productDetailsBloc.product,
          builder:
              (BuildContext context, AsyncSnapshot<Product> productSnapshot) {
            Product product = productSnapshot.data ?? Product();
            return Padding(
              padding:
                  const EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ModalService.modalDragHandle(),
                  const SizedBox(height: 24.0),
                  ModalService.modalTitle(product.title),
                  const SizedBox(height: 16.0),
                  const ZenDivider(),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(top: 24.0, bottom: 48.0),
                      physics: const ClampingScrollPhysics(),
                      children: [
                        labelWithInputField(
                            Strings.title, titleEditingController,
                            maxLines: null),
                        const SizedBox(height: 16.0),
                        Row(
                          children: [
                            SizedBox(
                              width: 107.0,
                              child: labelWithInputField(
                                Strings.price,
                                priceEditingController,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                              ),
                            ),
                            const SizedBox(width: 16.0),
                            Expanded(
                              child: labelWithDropdown(
                                Strings.category,
                                editProduct.category,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        labelWithInputField(
                            Strings.description, descriptionEditingController,
                            maxLines: null),
                        const SizedBox(height: 16.0),
                        gallerySection(),
                        const SizedBox(height: 27.0),
                        const ZenDivider(),
                        const SizedBox(height: 24.0),
                        PrimaryButton(
                          text: Strings.save,
                          onPressed: productDetailsBloc.isSaveEnabled(
                                  product, editProduct)
                              ? () =>
                                  onSavePressed(context, product, editProduct)
                              : null,
                        ),
                        const SizedBox(height: 16.0),
                        PrimaryButton(
                          text: Strings.cancel,
                          filled: false,
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget labelWithInputField(String title, TextEditingController controller,
          {int? maxLines = 1,
          TextInputType keyboardType = TextInputType.text}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sectionTitle(title),
          const SizedBox(height: 8.0),
          InputField(
            hintText: '',
            textEditingController: controller,
            borderColor: ColorConstants.third,
            borderRadius: 4.0,
            maxLines: maxLines,
            keyboardType: keyboardType,
          ),
        ],
      );

  Widget labelWithDropdown(String title, String selectedCategory) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sectionTitle(title),
          const SizedBox(height: 8.0),
          PrimaryDropdown(
            value: selectedCategory,
            items: categories
                .where((e) => e != FilterConstants.defaultCategory)
                .toList(),
            onChanged: onCategoryChanged,
          ),
        ],
      );

  Widget sectionTitle(String title) => Text(
        title,
        style: const TextStyle(
          fontSize: 17.0,
          fontWeight: FontWeight.w600,
          color: ColorConstants.dark,
          letterSpacing: -0.34,
        ),
      );

  Widget gallerySection() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sectionTitle(Strings.image),
          const SizedBox(height: 8.0),
          Wrap(
            direction: Axis.horizontal,
            spacing: 8.0,
            runSpacing: 8.0,
            children: List.generate(
              product.image.split(',').length + 1,
              (index) => ProductGalleryImage(
                image: index == product.image.split(',').length
                    ? null
                    : product.image.split(',')[index],
              ),
            ),
          ),
        ],
      );
}
