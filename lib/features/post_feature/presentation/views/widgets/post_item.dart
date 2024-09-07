import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:product_pulse/core/utils/styles.dart';
import 'package:product_pulse/core/widgets/custom_user_circle_avatar.dart';
import 'package:product_pulse/features/post_feature/data/models/post_model.dart';
import 'package:product_pulse/features/post_feature/data/models/user_data_model.dart';
import 'package:product_pulse/features/post_feature/presentation/manager/delete_post/delete_post_cubit.dart';
import 'package:product_pulse/features/post_feature/presentation/views/reactions_view.dart';
import 'package:product_pulse/features/chat/presentation/views/users_chat_view.dart';
import 'package:product_pulse/features/post_feature/presentation/views/widgets/image_preview_view.dart';
import 'package:product_pulse/features/post_feature/presentation/views/widgets/row_of_star_and_comments.dart';

enum Menu { contact, remove }

class PostItem extends StatefulWidget {
  const PostItem(
      {super.key,
      required this.postItem,
      required this.userDataModel,
      required this.postTime});

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
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        decoration: BoxDecoration(boxShadow: const [
          BoxShadow(
            spreadRadius: 1,
            blurRadius: 1,
            color: Colors.grey,
          )
        ], borderRadius: BorderRadius.circular(8), color: Colors.white),
        child: Column(
          children: [
            ListTile(
              leading: CustomUserCircleAvatar(
                userImage: widget.postItem.userImage,
              ),
              title: Text(
                '${widget.postItem.firstName} ${widget.postItem.lastName}',
                style: Style.font18Medium(context),
              ),
              subtitle: Row(
                children: [
                  Text(widget.postTime),
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(
                    FontAwesomeIcons.earthAmericas,
                    size: 15,
                  ),
                ],
              ),
              trailing: PopupMenuButton<Menu>(
                position: PopupMenuPosition.under,
                surfaceTintColor: const Color(0xffffffff),
                popUpAnimationStyle: _animationStyle,
                icon: const Icon(Icons.more_vert),
                onSelected: (Menu item) {},
                itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                  widget.postItem.userId ==
                          FirebaseAuth.instance.currentUser!.uid
                      ? PopupMenuItem<Menu>(
                          onTap: () async {
                            await BlocProvider.of<DeletePostCubit>(context)
                                .deletePost(postId: widget.postItem.postId);
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
                              return UsersChatView(
                                imageOfMe: widget.userDataModel.image,
                                nameOfme: widget.userDataModel.fullName,
                                image: widget.postItem.image,
                                newFullName:
                                    '${widget.postItem.firstName} ${widget.postItem.lastName}',
                                userEmail: widget.postItem.userEmail,
                                name:
                                    '${widget.postItem.firstName}${widget.postItem.lastName}',
                              );
                            }));
                          },
                          value: Menu.contact,
                          child: ListTile(
                            leading: const Icon(Icons.message_outlined),
                            title: Text(
                              'Chat With',
                              style: Style.font14SemiBold(context),
                            ),
                          ),
                        )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 16, left: 16, bottom: 16, top: 4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.postItem.title,
                  style: Style.font18Medium(context),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 16, left: 16, bottom: 16, top: 4),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ImagePreviewScreen(
                        imageUrl: widget.postItem.image,
                        imageId:
                            '${widget.postItem.postId} ${widget.postItem.userId} ${widget.postItem.userEmail}', // Use postId as the unique tag
                      ),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    width: double.infinity,
                    fit: BoxFit.fill,
                    imageUrl: widget.postItem.image,
                    scale: 1,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xff1F41BB),
                      ),
                    ),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                      size: 40,
                      color: Color(0xff1F41BB),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 16, left: 16, bottom: 16, top: 4),
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
                            children: [
                              const Icon(
                                Icons.star,
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
