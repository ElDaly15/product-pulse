import 'package:flutter/material.dart';

class SelectImage extends StatelessWidget {
  const SelectImage({super.key, required this.onPressed});
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        style: IconButton.styleFrom(
          backgroundColor: const Color(0xff1F41BB),
        ),
        onPressed: onPressed,
        icon: const Icon(
          Icons.camera_alt,
          color: Colors.white,
        ));
  }
}
