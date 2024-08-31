import 'package:flutter/material.dart';
import 'package:product_pulse/core/utils/styles.dart';

class CustomStartAppButtom extends StatelessWidget {
  const CustomStartAppButtom(
      {super.key,
      required this.colorId,
      required this.colorText,
      required this.text,
      required this.onPressed});

  final int colorId;
  final int colorText;
  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: Color(colorId),
        elevation: 0,
        minimumSize: const Size(120, 45),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: Style.font20SemiBold(context).copyWith(color: Color(colorText)),
      ),
    );
  }
}
