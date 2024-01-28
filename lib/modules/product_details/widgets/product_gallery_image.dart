import 'package:e_commerce/data/constants/assets.dart';
import 'package:e_commerce/data/constants/color_constants.dart';
import 'package:e_commerce/data/reusable_widgets/zen_icon_button.dart';
import 'package:e_commerce/utils/painters/dashed_border_painter.dart';
import 'package:flutter/material.dart';

class ProductGalleryImage extends StatelessWidget {
  final String? image;
  const ProductGalleryImage({super.key, this.image});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        CustomPaint(
          painter: DashedBorderPainter(
              color: ColorConstants.main, strokeWidth: 1.0, gap: 2.0),
          child: Container(
            height: 103.0,
            width: 103.0,
            padding: const EdgeInsets.only(
                top: 15.0, bottom: 10.0, left: 22.5, right: 25.5),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(6.0)),
            ),
            child: image == null
                ? ZenIconButton(icon: Assets.add, onPressed: () {})
                : Image.network(image!),
          ),
        ),
        if (image != null)
          Padding(
            padding: const EdgeInsets.only(top: 6.0, right: 6.0),
            child: ZenIconButton(icon: Assets.delete, onPressed: () {}),
          ),
      ],
    );
  }
}
