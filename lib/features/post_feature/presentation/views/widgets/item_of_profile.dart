// ignore_for_file: use_build_context_synchronously, duplicate_ignore

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
import 'package:product_pulse/features/chat/presentation/views/users_chat_view.dart';
import 'package:product_pulse/features/post_feature/data/models/user_data_model.dart';
import 'package:product_pulse/features/post_feature/presentation/manager/get_user_data/get_user_data_cubit.dart';
import 'package:product_pulse/features/post_feature/presentation/manager/update_user_data/update_user_data_cubit.dart';
import 'package:product_pulse/features/post_feature/presentation/views/widgets/custom_profile_avatar.dart';
import 'package:product_pulse/features/post_feature/presentation/views/widgets/image_preview_view.dart';
import 'package:product_pulse/features/post_feature/presentation/views/widgets/select_image_icon.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:path/path.dart' as path;

class ItemOfProfile extends StatefulWidget {
  const ItemOfProfile(
      {super.key,
      required this.userDataModel,
      required this.onSubmitData,
      required this.myData});
  // final String name;
  // final String userImage;
  final UserDataModel userDataModel;
  final UserDataModel myData;

  final void Function(bool isAsync) onSubmitData;

  @override
  State<ItemOfProfile> createState() => _ItemOfProfileState();
}

File? imageFile;
File? file;
File? secondFile;
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

  Future<void> getImageForProfile({required ImageSource source}) async {
    final ImagePicker picker = ImagePicker();
    final XFile? imageCamera = await picker.pickImage(source: source);
    widget.onSubmitData(true);
    try {
      if (imageCamera != null) {
        isAsync = true;
        setState(() {});
        secondFile = File(imageCamera.path);
        var imageName = path.basename(imageCamera.path);
        var refStorage = FirebaseStorage.instance.ref(imageName);
        await refStorage.putFile(secondFile!);
        secondUrl = await refStorage.getDownloadURL();
        await BlocProvider.of<UpdateUserDataCubit>(context).updateImage(
          uid: FirebaseAuth.instance.currentUser!.uid,
          image: secondUrl ?? widget.userDataModel.image,
        );
        await BlocProvider.of<UpdateUserDataCubit>(context).updatePostImage(
          uid: FirebaseAuth.instance.currentUser!.uid,
          image: secondUrl ?? widget.userDataModel.image,
        );

        isAsync = false;
        widget.onSubmitData(false);

        setState(() {});
      }
    } catch (e) {
      widget.onSubmitData(false);
    } finally {
      widget.onSubmitData(false);
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
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => ImagePreviewScreen(
                              imageId: '1',
                              imageUrl: widget.userDataModel.coverImage,
                            )),
                  );
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
            ),
            // Profile Avatar
            FirebaseAuth.instance.currentUser!.uid == widget.userDataModel.uid
                ? Positioned(
                    bottom: -50,
                    left: 15,
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => ImagePreviewScreen(
                                        imageId: '1',
                                        imageUrl: widget.userDataModel.image,
                                      )),
                            );
                          },
                          child: CircleAvatar(
                            radius: 62,
                            backgroundColor: Colors.white,
                            child: CustomProfileAvatar(
                                userImage: widget.userDataModel.image),
                          ),
                        ),
                      ],
                    ),
                  )
                : Positioned(
                    bottom: -50,
                    left: 15,
                    child: CircleAvatar(
                      radius: 62,
                      backgroundColor: Colors.white,
                      child: CustomProfileAvatar(
                          userImage: widget.userDataModel.image),
                    )),

            FirebaseAuth.instance.currentUser!.uid == widget.userDataModel.uid
                ? Positioned(
                    bottom: -20,
                    right: 15,
                    child: SelectImage(
                      onPressed: () {
                        // _imgFromGalleryForCover();

                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              backgroundColor: Colors.white,
                              child: SizedBox(
                                width: 30,
                                child: AspectRatio(
                                  aspectRatio: 2 / 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Spacer(),
                                      ListTile(
                                        onTap: () {
                                          getImageForProfile(
                                              source: ImageSource.gallery);
                                          Navigator.pop(context);
                                        },
                                        leading: const Icon(
                                          Icons.account_circle_outlined,
                                          color: Colors.black,
                                        ),
                                        title: Text(
                                          'Edit Profile Picture',
                                          style: Style.font18Medium(context),
                                        ),
                                      ),
                                      ListTile(
                                        onTap: () {
                                          _imgFromGalleryForCover();
                                          Navigator.pop(context);
                                        },
                                        leading: const Icon(
                                          Icons.image_outlined,
                                          color: Colors.black,
                                        ),
                                        title: Text(
                                          'Edit Cover Picture',
                                          style: Style.font18Medium(context),
                                        ),
                                      ),
                                      const Spacer(),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  )
                : Positioned(
                    bottom: -20,
                    right: 15,
                    child: IconButton(
                        style: IconButton.styleFrom(
                            backgroundColor: const Color(0xff1F41BB)),
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return UsersChatView(
                              imageOfMe: widget.myData.image,
                              nameOfme: widget.myData.fullName,
                              image: widget.userDataModel.image,
                              newFullName: widget.userDataModel.fullName,
                              userEmail: widget.userDataModel.email,
                              name: widget.userDataModel.fullName,
                            );
                          }));
                        },
                        icon: const Icon(
                          Icons.chat,
                          color: Colors.white,
                        )),
                  ),
            // User's name
            Positioned(
              bottom: -40,
              left: 140,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  widget.userDataModel.fullName,
                  style: Style.font22SemiBold(context),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
