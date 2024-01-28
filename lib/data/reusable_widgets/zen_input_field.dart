import 'package:e_commerce/data/constants/color_constants.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final String hintText;
  final Widget? prefixIcon;
  final Color fillColor;
  final double borderRadius;
  final Color? borderColor;
  final int? maxLines;
  final TextInputType keyboardType;

  const InputField({
    super.key,
    this.textEditingController,
    required this.hintText,
    this.prefixIcon,
    this.fillColor = ColorConstants.light,
    this.borderRadius = 50.0,
    this.borderColor,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      keyboardType: keyboardType,
      style: const TextStyle(
        fontSize: 13.0,
        color: ColorConstants.dark,
        letterSpacing: -0.26,
        fontWeight: FontWeight.w400,
      ),
      cursorColor: ColorConstants.main,
      maxLines: maxLines,
      decoration: InputDecoration(
        constraints: maxLines == null
            ? const BoxConstraints()
            : const BoxConstraints(minHeight: 48.0, maxHeight: 48.0),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 13.0,
          fontWeight: FontWeight.w400,
          color: ColorConstants.main.withOpacity(0.5),
          letterSpacing: -0.26,
        ),
        prefixIcon: prefixIcon,
        contentPadding: const EdgeInsets.all(12.0),
        fillColor: fillColor,
        filled: true,
        border: border(),
        enabledBorder: border(),
        focusedBorder: border(),
      ),
    );
  }

  InputBorder border() => OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        gapPadding: 12.0,
        borderSide: borderColor == null
            ? BorderSide.none
            : BorderSide(
                color: borderColor!,
                width: 1.0,
              ),
      );
}
