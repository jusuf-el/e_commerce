import 'package:e_commerce/data/constants/color_constants.dart';
import 'package:flutter/material.dart';

class ZenDivider extends StatelessWidget {
  const ZenDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: ColorConstants.neutral,
      thickness: 1.0,
      height: 1.0,
    );
  }
}
