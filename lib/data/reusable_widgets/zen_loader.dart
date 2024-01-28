import 'package:e_commerce/data/constants/color_constants.dart';
import 'package:flutter/material.dart';

class ZenLoader extends StatelessWidget {
  final double padding;

  const ZenLoader({super.key, this.padding = 0.0});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: const FittedBox(
        fit: BoxFit.scaleDown,
        child: CircularProgressIndicator(
          color: ColorConstants.main,
        ),
      ),
    );
  }
}
