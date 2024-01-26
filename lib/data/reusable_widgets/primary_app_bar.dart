import 'package:e_commerce/data/constants/assets.dart';
import 'package:e_commerce/data/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg_flutter.dart';

class PrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PrimaryAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0.0,
      leading: IconButton(
        onPressed: () {},
        icon: SvgPicture.asset(
          Assets.arrowBack,
          width: 24.0,
          height: 24.0,
        ),
      ),
      title: const Text(
        'Products',
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w700,
          color: ColorConstants.baseBlack,
          letterSpacing: -0.36,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
