import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_pulse/core/utils/styles.dart';
import 'package:product_pulse/features/post_feature/data/models/post_model.dart';
import 'package:product_pulse/features/post_feature/data/models/user_data_model.dart';
import 'package:product_pulse/features/post_feature/presentation/manager/reaction_handle/reaction_handle_cubit.dart';
import 'package:product_pulse/features/post_feature/presentation/views/comments_view.dart';

class RowOfStarAndComments extends StatelessWidget {
  const RowOfStarAndComments(
      {super.key,
      required this.likes,
      required this.postModel,
      required this.userDataModel});

  final List<dynamic> likes;
  final PostModel postModel;
  final UserDataModel userDataModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffffffff), elevation: 0),
          onPressed: () {
            bool checkLike = likes.any((like) {
              return like['uid'] == FirebaseAuth.instance.currentUser!.uid;
            });

            if (checkLike) {
              BlocProvider.of<ReactionHandleCubit>(context).deleteReaction(
                  postId: postModel.postId,
                  name: '${userDataModel.firstName} ${userDataModel.lastName}',
                  userImage: userDataModel.image);
            } else {
              BlocProvider.of<ReactionHandleCubit>(context).addReaction(
                  postId: postModel.postId,
                  name: '${userDataModel.firstName} ${userDataModel.lastName}',
                  userImage: userDataModel.image);
            }
          },
          child: Row(
            children: [
              Icon(
                likes.any(
                  (like) {
                    if (like['uid'] == FirebaseAuth.instance.currentUser!.uid) {
                      return true;
                    } else {
                      return false;
                    }
                  },
                )
                    ? Icons.star
                    : Icons.star_border,
                color: Colors.black,
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
                userDataModel: userDataModel,
                postModel: postModel,
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
