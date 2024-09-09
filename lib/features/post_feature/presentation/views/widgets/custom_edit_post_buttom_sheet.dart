import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:product_pulse/core/utils/styles.dart';
import 'package:product_pulse/core/widgets/custom_edit_text_field.dart';
import 'package:path/path.dart' as path;
import 'package:product_pulse/core/widgets/custom_snack_bar.dart';
import 'package:product_pulse/features/post_feature/data/models/post_model.dart';
import 'package:product_pulse/features/post_feature/presentation/manager/update_post/update_post_cubit.dart';

class CustomEditPostBottomSheet extends StatefulWidget {
  const CustomEditPostBottomSheet({
    super.key,
    required this.lastTitleOfPost,
    required this.postModel,
  });

  final String lastTitleOfPost;
  final PostModel postModel;

  @override
  State<CustomEditPostBottomSheet> createState() =>
      _CustomEditPostBottomSheetState();
}

File? file;
String? url;

bool isAsync = false;

String? newTitle;

class _CustomEditPostBottomSheetState extends State<CustomEditPostBottomSheet> {
  Future<void> getImage({required ImageSource source}) async {
    setState(() {
      isAsync = true;
    });

    try {
      final ImagePicker picker = ImagePicker();
      final XFile? imageCamera = await picker.pickImage(source: source);

      if (imageCamera != null) {
        file = File(imageCamera.path);
        var imageName = path.basename(imageCamera.path);
        var refStorage = FirebaseStorage.instance.ref(imageName);
        await refStorage.putFile(file!);
        url = await refStorage.getDownloadURL();
      }
    } catch (e) {
      // Handle error and show a message
      CustomSnackBar().showSnackBar(
        // ignore: use_build_context_synchronously
        context: context,
        msg: 'Error while uploading image',
      );
    } finally {
      setState(() {
        isAsync = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdatePostCubit, UpdatePostState>(
      listener: (context, state) {
        if (state is UpdatePostSuccess) {
          Navigator.pop(context);
          CustomSnackBar().showSnackBar(context: context, msg: 'Post Updated');
          url = null;
          newTitle = null;
        }
        if (state is UpdatePostFailuer) {
          CustomSnackBar()
              .showSnackBar(context: context, msg: 'Error while updating post');
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                right: 16,
                left: 16,
                top: 8,
                bottom: MediaQuery.viewInsetsOf(context).bottom),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Edit Post Content',
                      style: Style.font18Bold(context),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: url == null && newTitle == null
                          ? null
                          : () async {
                              BlocProvider.of<UpdatePostCubit>(context)
                                  .updatePost(
                                      firstName: widget.postModel.firstName,
                                      lastName: widget.postModel.lastName,
                                      title: newTitle ?? widget.postModel.title,
                                      category: widget.postModel.category,
                                      postId: widget.postModel.postId,
                                      image: url == null
                                          ? widget.postModel.image
                                          : url!,
                                      userImage: widget.postModel.userImage,
                                      userId: widget.postModel.userId,
                                      userEmail: widget.postModel.userEmail,
                                      postTime: widget.postModel.timestamp!,
                                      likes: widget.postModel.likes,
                                      comments: widget.postModel.comments);
                            },
                      child: state is UpdatePostLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                              color: Color(0xff1F41BB),
                            ))
                          : Text(
                              'Save',
                              style: Style.font18Bold(context).copyWith(
                                  color: url == null && newTitle == null
                                      ? const Color(0xff1F41BB).withOpacity(0.2)
                                      : const Color(0xff1F41BB)),
                            ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomEditTextField(
                    hintTitle: 'Edit Post Content',
                    obscure: false,
                    isPassword: false,
                    focusNode: FocusNode(),
                    onFieldSubmitted: (value) {
                      newTitle = value;
                      setState(() {});
                    },
                    textOfLastEdit: widget.lastTitleOfPost),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Edit Post Image',
                  style: Style.font18Bold(context),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 135,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          backgroundColor: const Color(0xff1F41BB),
                          minimumSize: const Size(10, 40)),
                      onPressed: () async {
                        await getImage(source: ImageSource.gallery);
                      },
                      child: isAsync
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                url != null
                                    ? Text(
                                        'Change',
                                        style: Style.font18SemiBold(context)
                                            .copyWith(color: Colors.white),
                                      )
                                    : Text(
                                        'Upload',
                                        style: Style.font18SemiBold(context)
                                            .copyWith(color: Colors.white),
                                      ),
                                const Icon(
                                  Icons.upload,
                                  color: Colors.white,
                                ),
                              ],
                            )),
                ),
                url != null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            width: double.infinity,
                            fit: BoxFit.cover,
                            imageUrl: url!,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(
                                color: Color(0xff1F41BB),
                              ),
                            ),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.error,
                              size: 40,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        );
      },
    );
  }
}
