import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:product_pulse/core/utils/images.dart';
import 'package:product_pulse/core/utils/styles.dart';
import 'package:path/path.dart' as path;
import 'package:product_pulse/core/widgets/custom_snack_bar.dart';

class CustomStartDataImageStack extends StatefulWidget {
  const CustomStartDataImageStack(
      {super.key, required this.onSubmitImage, required this.status});

  final Function(String image) onSubmitImage;
  final Function(bool load) status;
  @override
  State<CustomStartDataImageStack> createState() =>
      _CustomStartDataImageStackState();
}

class _CustomStartDataImageStackState extends State<CustomStartDataImageStack> {
  File? file;

  String? url;

  Future<void> getImage({required ImageSource source}) async {
    final ImagePicker picker = ImagePicker();
    final XFile? imageCamera = await picker.pickImage(source: source);

    if (imageCamera != null) {
      widget.status(true);
      setState(() {});
      file = File(imageCamera.path);
      var imageName = path.basename(imageCamera.path);
      var refStorage = FirebaseStorage.instance.ref(imageName);
      await refStorage.putFile(file!);
      url = await refStorage.getDownloadURL();
      widget.onSubmitImage(url!);
      widget.status(false);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          SizedBox(
            width: 140, // Adjust as needed
            height: 140, // Adjust as needed
            child: ClipOval(
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: url ?? Assets.imageOfStartUser,
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
                                      onPressed: () async {
                                        try {
                                          setState(() {});

                                          await getImage(
                                              source: ImageSource.camera);
                                          // ignore: use_build_context_synchronously
                                          Navigator.pop(context);
                                          widget.onSubmitImage(url!);

                                          CustomSnackBar().showSnackBar(
                                              // ignore: use_build_context_synchronously
                                              context: context,
                                              msg: 'Image Uploaded');
                                          widget.status(false);
                                          setState(() {});
                                        } catch (e) {
                                          CustomSnackBar().showSnackBar(
                                              // ignore: use_build_context_synchronously
                                              context: context,
                                              msg: 'An Error Occured');
                                          widget.status(false);
                                          setState(() {});
                                        }
                                      },
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
                                      onPressed: () async {
                                        try {
                                          await getImage(
                                              source: ImageSource.gallery);

                                          CustomSnackBar().showSnackBar(
                                              // ignore: use_build_context_synchronously
                                              context: context,
                                              msg: 'Uploaded');
                                          widget.status(false);
                                          setState(() {});
                                        } catch (e) {
                                          CustomSnackBar().showSnackBar(
                                              // ignore: use_build_context_synchronously
                                              context: context,
                                              msg: 'error');
                                          widget.status(false);
                                          setState(() {});
                                        }
                                      },
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
