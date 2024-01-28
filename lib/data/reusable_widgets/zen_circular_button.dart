import 'package:e_commerce/data/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg_flutter.dart';

class ZenCircularButton extends StatelessWidget {
  final Function() onTap;
  final String icon;
  final bool displayNotification;

  const ZenCircularButton({
    super.key,
    required this.onTap,
    required this.icon,
    this.displayNotification = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(22)),
      onTap: onTap,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
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
          if (displayNotification)
            Padding(
              padding: const EdgeInsets.only(top: 9.0, right: 9.0),
              child: Container(
                height: 8.0,
                width: 8.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorConstants.main,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
