import 'package:flutter/material.dart';

class SocialMediaConnectButtom extends StatelessWidget {
  const SocialMediaConnectButtom(
      {super.key, required this.image, this.onPressed});
  final String image;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xffECECEC),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      onPressed: onPressed,
      child: Image.asset(image),
    );
  }
}
