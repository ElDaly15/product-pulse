import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:product_pulse/core/utils/images.dart';

class CustomUserCircleAvatar extends StatelessWidget {
  const CustomUserCircleAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: const Color(0xff1F41BB).withOpacity(0.2),
      child: ClipOval(
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: Assets.imageOfStartUser,
          placeholder: (context, url) => const CircularProgressIndicator(
            color: Color(0xff1F41BB),
          ),
          errorWidget: (context, url, error) => const Icon(
            Icons.error,
            size: 40,
            color: Color(0xff1F41BB),
          ),
        ),
      ),
    );
  }
}
