import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:product_pulse/core/utils/styles.dart';

class PreviewChatUserImage extends StatelessWidget {
  const PreviewChatUserImage(
      {super.key, required this.imageUrl, required this.fullNameOfUser});
  final String imageUrl;
  final String fullNameOfUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          fullNameOfUser,
          style: Style.font22SemiBold(context).copyWith(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: PhotoView(
            imageProvider: CachedNetworkImageProvider(imageUrl),
            initialScale: PhotoViewComputedScale.contained,
            minScale: PhotoViewComputedScale.contained * 0.8,
            maxScale: PhotoViewComputedScale.covered * 2,
            enableRotation: true,
            backgroundDecoration: const BoxDecoration(color: Colors.black),
            loadingBuilder: (context, event) => const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xff1F41BB),
                  ),
                )),
      ),
    );
  }
}
