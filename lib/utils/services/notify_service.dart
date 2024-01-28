import 'package:e_commerce/data/constants/color_constants.dart';
import 'package:flutter/material.dart';

class NotifyService {
  static void showErrorMessage(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: ColorConstants.main,
        content: Text(
          errorMessage,
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            letterSpacing: -0.24,
          ),
        ),
      ),
    );
  }

  static void showSuccessMessage(BuildContext context, String successMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          successMessage,
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            letterSpacing: -0.24,
          ),
        ),
      ),
    );
  }
}
