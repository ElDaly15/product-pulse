import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:product_pulse/core/utils/images.dart';
import 'package:product_pulse/core/utils/styles.dart';

class CustomStartDataImageStack extends StatelessWidget {
  const CustomStartDataImageStack({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xff1F41BB).withOpacity(0.2),
            radius: 70,
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
          ),
          Positioned(
            bottom: 10,
            right: 0,
            child: IconButton(
              iconSize: 30,
              style: IconButton.styleFrom(
                  backgroundColor: const Color(0xff1F41BB)),
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return SingleChildScrollView(
                        // ignore: avoid_unnecessary_containers
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    IconButton(
                                      style: IconButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xff1F41BB)),
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.camera,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      'Camera',
                                      style: Style.font14SemiBold(context),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                      style: IconButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xff1F41BB)),
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.photo,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      'Gallery',
                                      style: Style.font14SemiBold(context),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              },
              icon: const Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 23,
              ),
            ),
          )
        ],
      ),
    );
  }
}
