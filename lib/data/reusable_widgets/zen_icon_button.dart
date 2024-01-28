import 'package:flutter/material.dart';
import 'package:svg_flutter/svg_flutter.dart';

class ZenIconButton extends StatelessWidget {
  final String icon;
  final Function() onPressed;
  final Color? iconColor;

  const ZenIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      style: const ButtonStyle(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      padding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      constraints: const BoxConstraints(),
      icon: SvgPicture.asset(
        icon,
        height: 24.0,
        width: 24.0,
        colorFilter: iconColor == null
            ? null
            : ColorFilter.mode(
                iconColor!,
                BlendMode.srcIn,
              ),
      ),
    );
  }
}
