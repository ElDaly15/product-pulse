import 'package:flutter/material.dart';
import 'package:product_pulse/core/utils/styles.dart';

class CustomRegistretionButtom extends StatelessWidget {
  const CustomRegistretionButtom(
      {super.key, required this.title, this.onPressed});
  final String title;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff1F41BB),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            minimumSize: const Size(double.infinity, 50)),
        onPressed: onPressed,
        child: Text(
          title,
          style: Style.font20SemiBold(context).copyWith(color: Colors.white),
        ));
  }
}
