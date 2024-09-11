import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:product_pulse/core/utils/images.dart';
import 'package:product_pulse/core/utils/styles.dart';
import 'package:product_pulse/features/post_feature/data/models/user_data_model.dart';
import 'package:product_pulse/features/post_feature/presentation/manager/get_user_data/get_user_data_cubit.dart';
import 'package:product_pulse/features/post_feature/presentation/manager/update_user_data/update_user_data_cubit.dart';
import 'package:product_pulse/features/post_feature/presentation/views/widgets/custom_profile_avatar.dart';
import 'package:product_pulse/features/post_feature/presentation/views/widgets/select_image_icon.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:path/path.dart' as path;

class ItemOfProfile extends StatefulWidget {
  const ItemOfProfile(
      {super.key,
      required this.name,
      required this.userImage,
      required this.userDataModel,
      required this.onSubmitData});
  final String name;
  final String userImage;
  final UserDataModel userDataModel;

  final void Function(bool isAsync) onSubmitData;

  @override
  State<ItemOfProfile> createState() => _ItemOfProfileState();
}

File? imageFile;
File? file;
String? secondUrl;
String? url;
bool isAsync = false;

class _ItemOfProfileState extends State<ItemOfProfile> {
  final picker = ImagePicker();

  Future<void> _imgFromGalleryForCover() async {
    final pickedImage =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (pickedImage != null) {
      _cropImage(File(pickedImage.path));
    }
  }

  // Crop the image
  Future<void> _cropImage(File imgFile) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imgFile.path,
      uiSettings: [
        AndroidUiSettings(
          aspectRatioPresets: [CropAspectRatioPreset.ratio16x9],
          statusBarColor: const Color(0xff1F41BB),
          activeControlsWidgetColor: const Color(0xff1F41BB),
          toolbarTitle: "Image Cropper",
          toolbarColor: const Color(0xff1F41BB),
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(title: "Image Cropper"),
      ],
    );

    if (croppedFile != null) {
      imageCache.clear();
      setState(() {
        imageFile = File(croppedFile.path);
      });
      await getImageForCover(pathImage: croppedFile.path);
    }
  }

  // Upload profile image

  // Upload cover image
  Future<void> getImageForCover({required String pathImage}) async {
    setState(() {
      widget.onSubmitData(true);
    });

    try {
      imageFile = File(pathImage);
      var imageName = path.basename(pathImage);
      var refStorage = FirebaseStorage.instance.ref(imageName);
      await refStorage.putFile(imageFile!);
      url = await refStorage.getDownloadURL();

      // Update user data with new cover image
      // ignore: use_build_context_synchronously
      await BlocProvider.of<UpdateUserDataCubit>(context).updateUserData(
        uid: FirebaseAuth.instance.currentUser!.uid,
        firstName: widget.userDataModel.firstName,
        lastName: widget.userDataModel.lastName,
        image: widget.userDataModel.image,
        birthDay: widget.userDataModel.birthDay,
        birthMonth: widget.userDataModel.birthMonth,
        birthYear: widget.userDataModel.birthYear,
        gender: widget.userDataModel.gender,
        bestProduct: widget.userDataModel.bestProduct,
        email: widget.userDataModel.email,
        coverImage: url ?? widget.userDataModel.coverImage,
      );
    } catch (e) {
      // Handle error and show a message
    } finally {
      setState(() {
        widget.onSubmitData(false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String coverImage = widget.userDataModel.coverImage;

    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            BlocListener<GetUserDataCubit, GetUserDataState>(
              listener: (context, state) {
                if (state is GetUserDataSuccess) {
                  setState(() {
                    coverImage = state.userDataModel.coverImage;
                  });
                }
              },
              child: CachedNetworkImage(
                width: double.infinity,
                fit: BoxFit.cover,
                imageUrl: coverImage,
                height: 210,
                placeholder: (context, url) => AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Skeletonizer(
                    enabled: true,
                    child: Image.asset(
                      Assets.imagesVectorLogin,
                      width: double.infinity,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                  size: 40,
                  color: Colors.red,
                ),
              ),
            ),
            // Profile Avatar
            Positioned(
              bottom: -50,
              left: 15,
              child: CircleAvatar(
                radius: 62,
                backgroundColor: Colors.white,
                child: CustomProfileAvatar(userImage: widget.userImage),
              ),
            ),

            Positioned(
              bottom: -20,
              right: 15,
              child: SelectImage(
                onPressed: () {
                  _imgFromGalleryForCover();
                },
              ),
            ),
            // User's name
            Positioned(
              bottom: -35,
              left: 145,
              child: Text(
                widget.name,
                style: Style.font22SemiBold(context),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
