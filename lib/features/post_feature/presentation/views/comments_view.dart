import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:product_pulse/core/widgets/custom_comment_text_field.dart';

import 'package:product_pulse/features/post_feature/presentation/views/widgets/comment_item.dart';
import 'package:product_pulse/features/post_feature/presentation/views/widgets/settings_app_bar.dart';

class CommentsView extends StatefulWidget {
  const CommentsView({super.key});

  @override
  State<CommentsView> createState() => _CommentsViewState();
}

class _CommentsViewState extends State<CommentsView> {
  TextEditingController textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  String? text;

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
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 12,
                itemBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: CommentItem(),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              color: Colors.white,
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: CustomCommentTextField(
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
                          : () {
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
