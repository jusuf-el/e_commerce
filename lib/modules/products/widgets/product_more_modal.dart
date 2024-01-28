import 'package:e_commerce/data/constants/assets.dart';
import 'package:e_commerce/data/models/product.dart';
import 'package:e_commerce/data/reusable_widgets/zen_button.dart';
import 'package:e_commerce/data/reusable_widgets/zen_divider.dart';
import 'package:e_commerce/utils/services/modal_service.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg_flutter.dart';

class ProductMoreModal extends StatelessWidget {
  final Product product;
  final Function() onEditPressed, onDeletePressed;

  const ProductMoreModal({
    super.key,
    required this.product,
    required this.onEditPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 16.0, right: 16.0, left: 16.0, bottom: 48.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ModalService.modalDragHandle(),
          const SizedBox(height: 24.0),
          ModalService.modalTitle(product.title),
          const SizedBox(height: 16.0),
          const ZenDivider(),
          const SizedBox(height: 24.0),
          PrimaryButton(
            text: 'Edit product',
            icon: Assets.edit,
            onPressed: onEditPressed,
          ),
          const SizedBox(height: 16.0),
          PrimaryButton(
            text: 'Delete product',
            filled: false,
            icon: Assets.delete,
            onPressed: onDeletePressed,
          ),
        ],
      ),
    );
  }
}
