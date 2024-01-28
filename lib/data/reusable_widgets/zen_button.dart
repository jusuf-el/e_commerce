import 'package:e_commerce/data/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final bool filled;
  final String? icon;
  final Function() onPressed;

  const PrimaryButton({
    super.key,
    required this.text,
    this.filled = true,
    this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      minWidth: double.infinity,
      elevation: 0.0,
      color: filled ? ColorConstants.main : Colors.white,
      padding: const EdgeInsets.all(18.0),
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        side: filled
            ? BorderSide.none
            : const BorderSide(
                color: ColorConstants.main,
                width: 1.0,
              ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            Row(
              children: [
                SvgPicture.asset(
                  icon!,
                  height: 24.0,
                  width: 24.0,
                  colorFilter: ColorFilter.mode(
                    filled ? Colors.white : ColorConstants.main,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 10.0),
              ],
            ),
          Text(
            text,
            style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.w600,
              color: filled ? Colors.white : ColorConstants.main,
              letterSpacing: -0.34,
            ),
          ),
        ],
      ),
    );
  }
}
