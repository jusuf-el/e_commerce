// import 'package:e_commerce/data/constants/assets.dart';
// import 'package:e_commerce/data/constants/color_constants.dart';
// import 'package:flutter/material.dart';
// import 'package:svg_flutter/svg_flutter.dart';
//
// class PrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
//   const PrimaryAppBar({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return
//       AppBar(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       elevation: 0.0,
//       forceMaterialTransparency: true,
//       leading: IconButton(
//         onPressed: () {},
//         icon: SvgPicture.asset(
//           Assets.arrowBack,
//           width: 24.0,
//           height: 24.0,
//         ),
//       ),
//       title: const Text(
//         'Products',
//         style: TextStyle(
//           fontSize: 18.0,
//           fontWeight: FontWeight.w700,
//           color: ColorConstants.baseBlack,
//           letterSpacing: -0.36,
//         ),
//       ),
//     );
//   }
//
//   @override
//   Size get preferredSize => AppBar().preferredSize;
// }

import 'package:e_commerce/data/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg_flutter.dart';

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
                  IconButton(
                    style: const ButtonStyle(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    constraints: const BoxConstraints(),
                    onPressed: onLeadingPressed ?? () {},
                    icon: SvgPicture.asset(
                      leadingIcon!,
                      height: 24.0,
                      width: 24.0,
                    ),
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
              IconButton(
                style: const ButtonStyle(
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                padding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                constraints: const BoxConstraints(),
                onPressed: onTrailingPressed ?? () {},
                icon: SvgPicture.asset(
                  trailingIcon!,
                  height: 24.0,
                  width: 24.0,
                  colorFilter: const ColorFilter.mode(
                    ColorConstants.baseBlack,
                    BlendMode.srcIn,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
