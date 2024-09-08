import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_pulse/core/utils/styles.dart';
import 'package:product_pulse/core/widgets/custom_edit_text_field.dart';
import 'package:product_pulse/core/widgets/custom_snack_bar.dart';
import 'package:product_pulse/features/post_feature/presentation/manager/get_comments/get_comments_cubit.dart';

class EditCommentView extends StatefulWidget {
  const EditCommentView(
      {super.key,
      required this.comment,
      required this.postId,
      required this.commentId,
      required this.userName,
      required this.userImage});
  final String comment;
  final String postId;
  final String commentId;
  final String userName;
  final String userImage;

  @override
  State<EditCommentView> createState() => _EditCommentViewState();
}

class _EditCommentViewState extends State<EditCommentView> {
  String? valueOfText;

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetCommentsCubit, GetCommentsState>(
      listener: (context, state) {
        if (state is GetCommentsSuccess) {
          Navigator.pop(context);
        }
        if (state is GetCommentsFailuer) {
          CustomSnackBar()
              .showSnackBar(context: context, msg: 'Comment Edited Failed');
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xffffffff),
        body: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SafeArea(
                  child: SizedBox(),
                ),
                Text(
                  'Edit Comment',
                  style: Style.font18Bold(context),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomEditTextField(
                  textOfLastEdit: widget.comment,
                  hintTitle: 'Edit Comment',
                  obscure: false,
                  isPassword: false,
                  focusNode: FocusNode(),
                  onFieldSubmitted: (v) {
                    valueOfText = v;

                    setState(() {});
                  },
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: Style.font18SemiBold(context)
                            .copyWith(color: const Color(0xff1F41BB)),
                      ),
                    ),
                    TextButton(
                      onPressed: valueOfText == null || valueOfText!.isEmpty
                          ? null
                          : () async {
                              await BlocProvider.of<GetCommentsCubit>(context)
                                  .editComment(
                                postId: widget.postId,
                                commentId: widget.commentId,
                                updatedCommentData: {
                                  'uid': FirebaseAuth.instance.currentUser!.uid,
                                  'comment': valueOfText,
                                  'commentId': widget.commentId,
                                  'userName': widget.userName,
                                  'userImage': widget.userImage
                                },
                              );
                            },
                      child: Text(
                        'Save',
                        style: Style.font18SemiBold(context).copyWith(
                            color: valueOfText == null || valueOfText!.isEmpty
                                ? const Color(0xff1F41BB).withOpacity(0.5)
                                : const Color(0xff1F41BB)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
