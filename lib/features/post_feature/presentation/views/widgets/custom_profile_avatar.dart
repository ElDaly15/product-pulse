import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomProfileAvatar extends StatelessWidget {
  const CustomProfileAvatar({super.key, required this.userImage});
  final String userImage;

  @override
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 60,
      backgroundColor: const Color(0xff1F41BB).withOpacity(0.2),
      child: ClipOval(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: userImage,
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
      ),
    );
  }
}
