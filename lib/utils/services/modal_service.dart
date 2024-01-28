import 'package:e_commerce/data/constants/assets.dart';
import 'package:e_commerce/data/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg_flutter.dart';

class ModalService {
  static openModal(BuildContext context, Widget child) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return child;
      },
      constraints: BoxConstraints(
        minWidth: double.infinity,
        maxHeight: MediaQuery.of(context).size.height,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        side: BorderSide.none,
      ),
      isScrollControlled: true,
      backgroundColor: ColorConstants.lightGrey,
    );
  }

  static Widget modalDragHandle() {
    return Center(
      child: SvgPicture.asset(Assets.dragHandle),
    );
  }

  static Widget modalTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
        color: ColorConstants.main,
        letterSpacing: -0.4,
      ),
    );
  }
}
