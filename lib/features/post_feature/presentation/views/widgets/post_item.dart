import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:product_pulse/core/utils/images.dart';
import 'package:product_pulse/core/utils/styles.dart';
import 'package:product_pulse/core/widgets/custom_snack_bar.dart';
import 'package:product_pulse/core/widgets/custom_user_circle_avatar.dart';
import 'package:product_pulse/features/post_feature/data/models/post_model.dart';
import 'package:product_pulse/features/post_feature/data/models/user_data_model.dart';
import 'package:product_pulse/features/post_feature/presentation/manager/delete_post/delete_post_cubit.dart';
import 'package:product_pulse/features/post_feature/presentation/views/reactions_view.dart';
import 'package:product_pulse/features/post_feature/presentation/views/user_profile_view.dart';
import 'package:product_pulse/features/post_feature/presentation/views/widgets/custom_edit_post_buttom_sheet.dart';
import 'package:product_pulse/features/post_feature/presentation/views/widgets/image_preview_view.dart';
import 'package:product_pulse/features/post_feature/presentation/views/widgets/row_of_star_and_comments.dart';
import 'package:skeletonizer/skeletonizer.dart';

enum Menu { contact, remove }

class PostItem extends StatefulWidget {
  const PostItem({
    super.key,
    required this.postItem,
    required this.userDataModel,
    required this.postTime,
  });

  final PostModel postItem;
  final UserDataModel userDataModel;
  final String postTime;

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  AnimationStyle? _animationStyle;

  @override
  void initState() {
    super.initState();
    _animationStyle = AnimationStyle(
      curve: Easing.emphasizedDecelerate,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1.2,
              blurRadius: 3,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return UserProfileView(
                    email: widget.postItem.userEmail,
                    myData: widget.userDataModel,
                    userDataModel: widget.userDataModel,
                  );
                }));
              },
              contentPadding:
                  const EdgeInsets.only(right: 10, left: 10, top: 5),
              leading: CustomUserCircleAvatar(
                userImage: widget.postItem.userImage,
              ),
              title: Text(
                '${widget.postItem.firstName} ${widget.postItem.lastName}',
                style: Style.font18Medium(context).copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              subtitle: Row(
                children: [
                  Text(widget.postTime,
                      style: TextStyle(color: Colors.grey[600])),
                  const SizedBox(width: 5),
                  const Icon(
                    FontAwesomeIcons.earthAmericas,
                    size: 15,
                    color: Colors.grey,
                  ),
                ],
              ),
              trailing: PopupMenuButton<Menu>(
                position: PopupMenuPosition.under,
                surfaceTintColor: const Color(0xffffffff),
                popUpAnimationStyle: _animationStyle,
                icon: const Icon(Icons.more_vert, color: Colors.black87),
                onSelected: (Menu item) {},
                itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                  widget.postItem.userId ==
                          FirebaseAuth.instance.currentUser!.uid
                      ? PopupMenuItem<Menu>(
                          onTap: () async {
                            showDialog(
                                context: context,
                                builder: (conetext) {
                                  return AlertDialog(
                                    contentPadding: const EdgeInsets.only(
                                        top: 12,
                                        left: 12,
                                        right: 12,
                                        bottom: 16),
                                    actionsPadding: const EdgeInsets.only(
                                        bottom: 5, right: 5),
                                    content: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, top: 4),
                                      child: Text(
                                        'Are you sure you want to delete this post?',
                                        style: Style.font18Bold(context),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'Cancel',
                                          style: Style.font18SemiBold(context)
                                              .copyWith(
                                                  color:
                                                      const Color(0xff1F41BB)),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          Navigator.pop(context);
                                          await BlocProvider.of<
                                                  DeletePostCubit>(context)
                                              .deletePost(
                                                  postId:
                                                      widget.postItem.postId);
                                        },
                                        child: Text(
                                          'Delete',
                                          style: Style.font18SemiBold(context)
                                              .copyWith(color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  );
                                });
                          },
                          value: Menu.remove,
                          child: ListTile(
                            leading: const Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                            ),
                            title: Text(
                              'Remove Post',
                              style: Style.font14SemiBold(context),
                            ),
                          ),
                        )
                      : PopupMenuItem<Menu>(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return UserProfileView(
                                email: widget.postItem.userEmail,
                                myData: widget.userDataModel,
                                userDataModel: widget.userDataModel,
                              );
                            }));
                          },
                          value: Menu.contact,
                          child: ListTile(
                            leading:
                                const Icon(Icons.person, color: Colors.black),
                            title: Text(
                              'Show Profile',
                              style: Style.font14SemiBold(context),
                            ),
                          ),
                        ),
                  FirebaseAuth.instance.currentUser!.uid ==
                          widget.postItem.userId
                      ? PopupMenuItem<Menu>(
                          onTap: () async {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return CustomEditPostBottomSheet(
                                  postModel: widget.postItem,
                                  lastTitleOfPost: widget.postItem.title,
                                );
                              },
                            );
                          },
                          value: Menu.remove,
                          child: ListTile(
                            leading: const Icon(
                              Icons.edit,
                              color: Colors.black,
                            ),
                            title: Text(
                              'Edit Post',
                              style: Style.font14SemiBold(context),
                            ),
                          ),
                        )
                      : PopupMenuItem<Menu>(
                          onTap: () async {
                            CustomSnackBar().showSnackBar(
                                context: context,
                                msg:
                                    'Post Report Send To Admins And Will Reviewed Soon');
                          },
                          value: Menu.remove,
                          child: ListTile(
                            leading: const Icon(
                              Icons.report,
                              color: Colors.black,
                            ),
                            title: Text(
                              'Report Post',
                              style: Style.font14SemiBold(context),
                            ),
                          ),
                        )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 16, left: 16, top: 4, bottom: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.postItem.title,
                  style: Style.font18Medium(context).copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ImagePreviewScreen(
                      imageUrl: widget.postItem.image,
                      imageId:
                          '${widget.postItem.postId} ${widget.postItem.userId} ${widget.postItem.userEmail}',
                    ),
                  ),
                );
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    width: double.infinity,
                    fit: BoxFit.cover, // Ensures the image fills its container
                    imageUrl: widget.postItem.image,
                    placeholder: (context, url) => AspectRatio(
                      aspectRatio: 16 / 9,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Skeletonizer(
                          enabled: true,
                          child: Image.asset(
                            Assets.imagesVectorLogin,
                            width: double.infinity,
                            fit: BoxFit
                                .cover, // Same behavior as the final image
                          ),
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  widget.postItem.likes.isEmpty
                      ? const SizedBox()
                      : GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return ReactionsView(
                                potsId: widget.postItem.postId,
                              );
                            }));
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.star_rate_rounded,
                                color: Colors.amber,
                              ),
                              Text(
                                widget.postItem.likes.length.toString(),
                                style: Style.font14SemiBold(context),
                              ),
                            ],
                          ),
                        ),
                  const Spacer(),
                  widget.postItem.comments.isEmpty
                      ? const SizedBox()
                      : Text('${widget.postItem.comments.length} Comments',
                          style: Style.font14SemiBold(context)),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
              endIndent: 20,
              indent: 20,
            ),
            RowOfStarAndComments(
              userDataModel: widget.userDataModel,
              postModel: widget.postItem,
              likes: widget.postItem.likes,
            ),
          ],
        ),
      ),
    );
  }
}
