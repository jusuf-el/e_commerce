import 'package:e_commerce/data/constants/color_constants.dart';
import 'package:e_commerce/data/reusable_widgets/zen_icon_button.dart';
import 'package:flutter/material.dart';

class ZenAppBar extends StatelessWidget {
  final String? leadingIcon, trailingIcon, title;
  final Function()? onLeadingPressed, onTrailingPressed;

  const ZenAppBar({
    super.key,
    this.leadingIcon,
    this.trailingIcon,
    this.title,
    this.onLeadingPressed,
    this.onTrailingPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 22.0, left: 16.0, right: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (leadingIcon != null)
                  ZenIconButton(
                    icon: leadingIcon!,
                    onPressed: onLeadingPressed ?? () {},
                  ),
                if (title != null)
                  Row(
                    children: [
                      const SizedBox(width: 24.0),
                      Text(
                        title!,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                          color: ColorConstants.baseBlack,
                          letterSpacing: -0.36,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            if (trailingIcon != null)
              ZenIconButton(
                icon: trailingIcon!,
                onPressed: onTrailingPressed ?? () {},
                iconColor: ColorConstants.baseBlack,
              ),
          ],
        ),
      ),
    );
  }
}
