import 'package:e_commerce/data/constants/assets.dart';
import 'package:e_commerce/data/constants/color_constants.dart';
import 'package:e_commerce/data/models/product.dart';
import 'package:e_commerce/data/reusable_widgets/zen_icon_button.dart';
import 'package:e_commerce/data/reusable_widgets/zen_image_error_builder.dart';
import 'package:e_commerce/data/reusable_widgets/zen_loader.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final Function() onProductPressed, onMorePressed;

  const ProductCard(
      {super.key,
      required this.product,
      required this.onProductPressed,
      required this.onMorePressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onProductPressed,
      child: Container(
        decoration: const BoxDecoration(
          color: ColorConstants.lightGrey,
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            productImage,
            const SizedBox(width: 16.0),
            productInfoSection,
            const SizedBox(width: 16.0),
            ZenIconButton(
              icon: Assets.moreVertical,
              onPressed: onMorePressed,
            ),
          ],
        ),
      ),
    );
  }

  Widget get productImage => Container(
        height: 70.0,
        width: 70.0,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 7.0),
        child: Image.network(
          product.image,
          loadingBuilder: (context, widget, event) {
            if (event?.expectedTotalBytes != event?.cumulativeBytesLoaded) {
              return const ZenLoader(padding: 8.0);
            } else {
              return widget;
            }
          },
          errorBuilder: (context, object, trace) {
            return const ZenImageErrorBuilder();
          },
        ),
      );

  Widget get productInfoSection => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.category.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 8.0,
                    fontWeight: FontWeight.w400,
                    color: ColorConstants.baseBlack,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  product.title,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                    color: ColorConstants.main,
                    letterSpacing: -0.24,
                  ),
                ),
              ],
            ),
            Text(
              '\$${product.price}',
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: ColorConstants.baseBlack,
                letterSpacing: -0.32,
              ),
            ),
          ],
        ),
      );
}
