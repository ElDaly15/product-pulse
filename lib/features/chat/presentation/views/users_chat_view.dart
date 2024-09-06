import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:product_pulse/core/widgets/custom_comment_text_field.dart';

import 'package:product_pulse/features/chat/presentation/views/widgets/chat_buuble.dart';
import 'package:product_pulse/features/chat/presentation/views/widgets/custom_chat_user_app_bar.dart';

class UsersChatView extends StatefulWidget {
  const UsersChatView({super.key, required this.name});

  final String name;
  @override
  State<UsersChatView> createState() => _UsersChatViewState();
}

class _UsersChatViewState extends State<UsersChatView> {
  TextEditingController controller = TextEditingController();

  final ScrollController _scrollController = ScrollController();
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
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(children: [
              const SafeArea(
                child: SizedBox(),
              ),
              CustomUserChatIAppBar(
                fullName: widget.name,
              ),
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  controller: _scrollController,
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return index % 2 == 0
                        ? const ChatWidgetBubble(msg: 'hi')
                        : const ChatWidgetBubblefriend(msg: 'bye');
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
              )
            ])));
  }
}
