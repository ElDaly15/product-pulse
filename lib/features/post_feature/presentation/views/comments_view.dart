import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:product_pulse/core/utils/styles.dart';
import 'package:product_pulse/core/widgets/custom_comment_text_field.dart';
import 'package:product_pulse/features/post_feature/data/models/post_model.dart';
import 'package:product_pulse/features/post_feature/data/models/user_data_model.dart';
import 'package:product_pulse/features/post_feature/presentation/manager/add_comment/add_comment_cubit.dart';
import 'package:product_pulse/features/post_feature/presentation/manager/get_comments/get_comments_cubit.dart';
import 'package:product_pulse/features/post_feature/presentation/views/edit_comment_view.dart';

import 'package:product_pulse/features/post_feature/presentation/views/widgets/comment_item.dart';
import 'package:product_pulse/features/post_feature/presentation/views/widgets/settings_app_bar.dart';

class CommentsView extends StatefulWidget {
  const CommentsView(
      {super.key, required this.postModel, required this.userDataModel});

  final PostModel postModel;
  final UserDataModel userDataModel;

  @override
  State<CommentsView> createState() => _CommentsViewState();
}

class _CommentsViewState extends State<CommentsView> {
  TextEditingController textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  String? text;

  @override
  void initState() {
    super.initState();
    getComments();
  }

  getComments() async {
    await BlocProvider.of<GetCommentsCubit>(context)
        .getComments(postId: widget.postModel.postId);
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          children: [
            const SafeArea(child: SizedBox()),
            const CustomAppBarForBackBtn(title: 'Comments'),
            BlocConsumer<GetCommentsCubit, GetCommentsState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is GetCommentsSuccess) {
                  if (state.comments.isNotEmpty) {
                    return Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: state.comments.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: GestureDetector(
                              onLongPress: () {
                                showModalBottomSheet(
                                    backgroundColor: const Color(0xffFFFFFF),
                                    context: context,
                                    builder: (context) {
                                      return SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            ListTile(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return EditCommentView(
                                                    userName: widget
                                                        .userDataModel.fullName,
                                                    userImage: widget
                                                        .userDataModel.image,
                                                    postId:
                                                        widget.postModel.postId,
                                                    commentId: state
                                                        .comments[index]
                                                        .commentId,
                                                    comment: state
                                                        .comments[index]
                                                        .comment,
                                                  );
                                                }));
                                              },
                                              leading: const Icon(
                                                Icons.edit,
                                                color: Colors.black,
                                              ),
                                              title: Text(
                                                'Edit Comment',
                                                style:
                                                    Style.font18Bold(context),
                                              ),
                                            ),
                                            ListTile(
                                              onTap: () {},
                                              leading: const Icon(
                                                Icons.delete,
                                                color: Colors.black,
                                              ),
                                              title: Text(
                                                'Delete Comment',
                                                style:
                                                    Style.font18Bold(context),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              },
                              child: CommentItem(
                                image: state.comments[index].image,
                                comment: state.comments[index].comment,
                                name: state.comments[index].name,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Expanded(
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              'No comments yet',
                              style: Style.font18Bold(context),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                } else if (state is GetCommentsFailuer) {
                  return Expanded(
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            'An Error Occured , Try Again later',
                            style: Style.font18Bold(context),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Expanded(
                    child: Column(
                      children: [
                        Center(
                            child: CircularProgressIndicator(
                          color: Color(0xff1F41BB),
                        )),
                      ],
                    ),
                  );
                }
              },
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              color: Colors.white,
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: CustomCommentTextField(
                        onFieldSubmitted: (v) {},
                        focusNode: _focusNode,
                        hintTitle: 'send a comment',
                        textEditingController: textEditingController,
                        obscure: false,
                        onSubmit: (value) {
                          text = value;
                          setState(() {});
                        },
                        isPassword: false),
                  ),
                  IconButton(
                      onPressed: text == null || text == ''
                          ? null
                          : () async {
                              await BlocProvider.of<AddCommentCubit>(context)
                                  .addComment(
                                      postId: widget.postModel.postId,
                                      comment: text!,
                                      userName:
                                          '${widget.userDataModel.firstName} ${widget.userDataModel.lastName}',
                                      userImage: widget.userDataModel.image);
                              textEditingController.clear();
                              _focusNode.unfocus();
                            },
                      icon: Icon(
                        FontAwesomeIcons.paperPlane,
                        color: text == null || text == ''
                            ? Colors.grey
                            : const Color(0xff1F41BB),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
