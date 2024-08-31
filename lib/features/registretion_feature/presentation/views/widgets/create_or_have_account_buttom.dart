import 'package:flutter/material.dart';
import 'package:product_pulse/core/utils/styles.dart';

class CheckAccountOrCreateNewButtom extends StatelessWidget {
  const CheckAccountOrCreateNewButtom(
      {super.key, required this.title, required this.onPressed});
  final String title;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xffffffff),
          elevation: 0,
          minimumSize: const Size(20, 20)),
      onPressed: onPressed,
      child: Text(
        title,
        style: Style.font14SemiBold(context).copyWith(
          color: const Color(0xff494949),
        ),
      ),
    );
  }
}
