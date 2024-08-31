import 'package:flutter/material.dart';
import 'package:product_pulse/core/utils/styles.dart';

class CustomSnackBar {
  void showSnackBar({required BuildContext context, required msg}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: Style.font18SemiBold(context).copyWith(color: Colors.white),
        ),
        backgroundColor: const Color(0xff1F41BB),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
