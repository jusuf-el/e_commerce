import 'package:e_commerce/data/constants/assets.dart';
import 'package:e_commerce/data/constants/color_constants.dart';
import 'package:e_commerce/data/constants/filter_constants.dart';
import 'package:e_commerce/data/models/product.dart';
import 'package:e_commerce/data/reusable_widgets/zen_input_field.dart';
import 'package:e_commerce/data/reusable_widgets/zen_button.dart';
import 'package:e_commerce/data/reusable_widgets/zen_dropdown.dart';
import 'package:e_commerce/modules/products/painters/dashed_border_painter.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg_flutter.dart';

class EditProductModal extends StatelessWidget {
  final Product product;
  final TextEditingController titleEditingController,
      priceEditingController,
      descriptionEditingController;
  final List<String> categories;

  const EditProductModal(
      {super.key,
      required this.product,
      required this.titleEditingController,
      required this.priceEditingController,
      required this.descriptionEditingController,
      required this.categories});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: SvgPicture.asset(Assets.dragHandle)),
          const SizedBox(height: 24.0),
          Text(
            product.title,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: ColorConstants.main,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 16.0),
          const Divider(
            color: ColorConstants.neutral,
            thickness: 1.0,
            height: 1.0,
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.only(
                top: 24.0,
                bottom: 48.0,
              ),
              physics: const ClampingScrollPhysics(),
              children: [
                const Text(
                  'Title',
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w600,
                    color: ColorConstants.dark,
                    letterSpacing: -0.34,
                  ),
                ),
                const SizedBox(height: 8.0),
                InputField(
                  hintText: '',
                  textEditingController: titleEditingController,
                  borderColor: ColorConstants.third,
                  borderRadius: 4.0,
                  maxLines: null,
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    SizedBox(
                      width: 107.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Price',
                            style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.w600,
                              color: ColorConstants.dark,
                              letterSpacing: -0.34,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          InputField(
                            hintText: '',
                            textEditingController: priceEditingController,
                            borderColor: ColorConstants.third,
                            borderRadius: 4.0,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Category',
                            style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.w600,
                              color: ColorConstants.dark,
                              letterSpacing: -0.34,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          PrimaryDropdown(
                            value: product.category,
                            items: categories
                                .where(
                                    (e) => e != FilterConstants.defaultCategory)
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w600,
                    color: ColorConstants.dark,
                    letterSpacing: -0.34,
                  ),
                ),
                const SizedBox(height: 8.0),
                InputField(
                  hintText: '',
                  textEditingController: descriptionEditingController,
                  borderColor: ColorConstants.third,
                  borderRadius: 4.0,
                  maxLines: null,
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'Image',
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w600,
                    color: ColorConstants.dark,
                    letterSpacing: -0.34,
                  ),
                ),
                const SizedBox(height: 8.0),
                Wrap(
                  direction: Axis.horizontal,
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: List.generate(
                    product.image.split(',').length + 1,
                    (index) {
                      return Stack(
                        alignment: Alignment.topRight,
                        children: [
                          CustomPaint(
                            painter: DashedBorderPainter(
                              color: ColorConstants.main,
                              strokeWidth: 1.0,
                              gap: 2.0,
                            ),
                            child: Container(
                              height: 103.0,
                              width: 103.0,
                              padding: const EdgeInsets.only(
                                top: 15.0,
                                bottom: 10.0,
                                left: 22.5,
                                right: 25.5,
                              ),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(6.0),
                                ),
                              ),
                              child: index == product.image.split(',').length
                                  ? SvgPicture.asset(
                                      Assets.add,
                                      height: 24.0,
                                      width: 24.0,
                                      fit: BoxFit.scaleDown,
                                    )
                                  : Image.network(
                                      product.image.split(',')[index]),
                            ),
                          ),
                          if (index < product.image.split(',').length)
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 6.0,
                                right: 6.0,
                              ),
                              child: SvgPicture.asset(
                                Assets.delete,
                                height: 24.0,
                                width: 24.0,
                                fit: BoxFit.scaleDown,
                              ),
                            )
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 27.0),
                const Divider(
                  color: ColorConstants.neutral,
                  thickness: 1.0,
                  height: 1.0,
                ),
                const SizedBox(height: 24.0),
                PrimaryButton(
                  text: 'Save',
                  onPressed: () {},
                ),
                const SizedBox(height: 16.0),
                PrimaryButton(
                  text: 'Cancel',
                  filled: false,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
