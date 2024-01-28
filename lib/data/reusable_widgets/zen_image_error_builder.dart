import 'package:e_commerce/data/constants/color_constants.dart';
import 'package:flutter/material.dart';

class ZenImageErrorBuilder extends StatelessWidget {
  final double? size;

  const ZenImageErrorBuilder({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.image_not_supported_outlined,
      color: ColorConstants.baseBlack,
      size: size,
    );
  }
}
