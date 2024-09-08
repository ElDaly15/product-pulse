import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_pulse/core/utils/styles.dart';
import 'package:product_pulse/features/post_feature/data/models/post_model.dart';
import 'package:product_pulse/features/post_feature/data/models/user_data_model.dart';
import 'package:product_pulse/features/post_feature/presentation/manager/reaction_handle/reaction_handle_cubit.dart';
import 'package:product_pulse/features/post_feature/presentation/views/comments_view.dart';

class RowOfStarAndComments extends StatefulWidget {
  const RowOfStarAndComments(
      {super.key,
      required this.likes,
      required this.postModel,
      required this.userDataModel});

  final List<dynamic> likes;
  final PostModel postModel;
  final UserDataModel userDataModel;

  @override
  // ignore: library_private_types_in_public_api
  _RowOfStarAndCommentsState createState() => _RowOfStarAndCommentsState();
}

class _RowOfStarAndCommentsState extends State<RowOfStarAndComments>
    with SingleTickerProviderStateMixin {
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes
        .any((like) => like['uid'] == FirebaseAuth.instance.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffffffff), elevation: 0),
          onPressed: () async {
            setState(() {
              isLiked = !isLiked; // Toggle the like state
            });

            bool checkLike = widget.postModel.likes.any((like) {
              return like['uid'] == FirebaseAuth.instance.currentUser!.uid;
            });

            if (checkLike) {
              await BlocProvider.of<ReactionHandleCubit>(context).deleteReaction(
                  postId: widget.postModel.postId,
                  name:
                      '${widget.userDataModel.firstName} ${widget.userDataModel.lastName}',
                  userImage: widget.userDataModel.image);
            } else {
              await BlocProvider.of<ReactionHandleCubit>(context).addReaction(
                  postId: widget.postModel.postId,
                  name:
                      '${widget.userDataModel.firstName} ${widget.userDataModel.lastName}',
                  userImage: widget.userDataModel.image);
            }
          },
          child: Row(
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(
                    scale: animation,
                    child: child,
                  );
                },
                child: Icon(
                  isLiked ? Icons.star : Icons.star_border,
                  key: ValueKey<bool>(isLiked),
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                'Star',
                style: Style.font18Medium(context),
              ),
            ],
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffffffff), elevation: 0),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return CommentsView(
                userDataModel: widget.userDataModel,
                postModel: widget.postModel,
              );
            }));
          },
          child: Row(
            children: [
              const Icon(Icons.comment, color: Colors.black),
              const SizedBox(
                width: 5,
              ),
              Text(
                'Comments',
                style: Style.font18Medium(context),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
