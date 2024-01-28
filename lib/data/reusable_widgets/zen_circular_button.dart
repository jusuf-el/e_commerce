import 'package:e_commerce/data/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg_flutter.dart';

class ZenCircularButton extends StatelessWidget {
  final Function() onTap;
  final String icon;

  const ZenCircularButton({
    super.key,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(22)),
      onTap: onTap,
      child: Container(
        height: 48.0,
        width: 48.0,
        decoration: const BoxDecoration(
            color: ColorConstants.light, shape: BoxShape.circle),
        child: SvgPicture.asset(
          icon,
          height: 24.0,
          width: 24.0,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
