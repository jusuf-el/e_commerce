import 'package:e_commerce/data/constants/color_constants.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final String hintText;
  final Widget? prefixIcon;

  const InputField({
    super.key,
    this.textEditingController,
    required this.hintText,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      style: const TextStyle(
        fontSize: 13.0,
        color: ColorConstants.main,
        letterSpacing: -0.26,
      ),
      cursorColor: ColorConstants.main,
      decoration: InputDecoration(
        constraints: const BoxConstraints(minHeight: 48.0, maxHeight: 48.0),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 13.0,
          fontWeight: FontWeight.w400,
          color: ColorConstants.main.withOpacity(0.5),
          letterSpacing: -0.26,
        ),
        prefixIcon: prefixIcon,
        contentPadding: const EdgeInsets.all(12.0),
        fillColor: ColorConstants.light,
        filled: true,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
          gapPadding: 12.0,
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
