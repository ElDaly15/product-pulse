import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImagePreviewScreen extends StatelessWidget {
  final String imageUrl;
  final String imageId;

  const ImagePreviewScreen({
    super.key,
    required this.imageUrl,
    required this.imageId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: PhotoView(
            imageProvider: CachedNetworkImageProvider(imageUrl),
            initialScale: PhotoViewComputedScale.contained,
            minScale: PhotoViewComputedScale.contained * 1,
            maxScale: PhotoViewComputedScale.covered * 2,
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
