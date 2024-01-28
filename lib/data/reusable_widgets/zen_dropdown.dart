import 'package:e_commerce/data/constants/assets.dart';
import 'package:e_commerce/data/constants/color_constants.dart';
import 'package:e_commerce/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg_flutter.dart';

class PrimaryDropdown extends StatelessWidget {
  final String value;
  final List<String> items;

  const PrimaryDropdown({
    super.key,
    required this.value,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorConstants.third,
            width: 1.0,
            strokeAlign: -1.0,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(4.0),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorConstants.third,
            width: 1.0,
            strokeAlign: -1.0,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(4.0),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorConstants.third,
            width: 1.0,
            strokeAlign: -1.0,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(4.0),
          ),
        ),
        contentPadding: EdgeInsets.all(12.0),
        constraints: BoxConstraints(maxHeight: 48.0),
        filled: true,
        fillColor: ColorConstants.light,
        isDense: true,
        labelStyle: TextStyle(
          fontSize: 13.0,
          color: ColorConstants.dark,
          letterSpacing: -0.26,
          fontWeight: FontWeight.w400,
        ),
      ),
      label: Text(
        value.capitalize(),
        style: const TextStyle(
          fontSize: 13.0,
          color: ColorConstants.dark,
          letterSpacing: -0.26,
          fontWeight: FontWeight.w400,
        ),
      ),
      expandedInsets: EdgeInsets.zero,
      trailingIcon: SvgPicture.asset(
        Assets.dropdown,
        height: 24.0,
        width: 24.0,
      ),
      selectedTrailingIcon: RotatedBox(
        quarterTurns: 2,
        child: SvgPicture.asset(
          Assets.dropdown,
          height: 24.0,
          width: 24.0,
        ),
      ),
      dropdownMenuEntries: List.generate(
        items.length,
        (index) {
          return DropdownMenuEntry(
            value: items[index],
            labelWidget: Text(
              items[index].capitalize(),
              style: const TextStyle(
                fontSize: 13.0,
                color: ColorConstants.dark,
                letterSpacing: -0.26,
                fontWeight: FontWeight.w400,
              ),
            ),
            label: items[index],
          );
        },
      ),
    );
  }
}
