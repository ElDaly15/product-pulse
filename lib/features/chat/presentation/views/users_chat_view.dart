import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:product_pulse/core/widgets/custom_comment_text_field.dart';
import 'package:product_pulse/features/chat/presentation/manager/add_message_cubit/add_message_cubit.dart';
import 'package:product_pulse/features/chat/presentation/manager/get_chat_messages_cubit/get_chat_messages_cubit.dart';

import 'package:product_pulse/features/chat/presentation/views/widgets/chat_buuble.dart';
import 'package:product_pulse/features/chat/presentation/views/widgets/custom_chat_user_app_bar.dart';

import '../../../../core/utils/styles.dart';

class UsersChatView extends StatefulWidget {
  const UsersChatView(
      {super.key,
      required this.name,
      required this.userEmail,
      required this.newFullName,
      required this.image,
      required this.imageOfMe,
      required this.nameOfme});

  final String name;
  final String userEmail;
  final String newFullName;

  final String imageOfMe, nameOfme;

  final String image;
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
  void initState() {
    super.initState();
    getMessages();
  }

  getMessages() async {
    await BlocProvider.of<GetChatMessagesCubit>(context).getMessage(
        email: FirebaseAuth.instance.currentUser!.email!,
        sendEmail: widget.userEmail);
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
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(children: [
              const SafeArea(
                child: SizedBox(),
              ),
              CustomUserChatIAppBar(
                fullName: widget.name,
              ),
              BlocConsumer<GetChatMessagesCubit, GetChatMessagesState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is GetChatMessagesSuccess) {
                    return Expanded(
                      child: ListView.builder(
                        reverse: true,
                        controller: _scrollController,
                        itemCount: state.messages.length,
                        itemBuilder: (context, index) {
                          return state.messages[index].emailSender ==
                                  FirebaseAuth.instance.currentUser!.email!
                              ? ChatWidgetBubble(msg: state.messages[index].msg)
                              : ChatWidgetBubblefriend(
                                  msg: state.messages[index].msg);
                        },
                      ),
                    );
                  } else if (state is GetChatMessagesLoading) {
                    return const Expanded(
                      child: Center(
                          child: CircularProgressIndicator(
                        color: Color(0xff1F41BB),
                      )),
                    );
                  } else {
                    return Expanded(
                      child: Text(
                        'An Error Occured',
                        style: Style.font18Bold(context),
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
                          onFieldSubmitted: (msg) {},
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
                                BlocProvider.of<AddMessageCubit>(context)
                                    .sendMessage(
                                        imageOfmE: widget.imageOfMe,
                                        nameOfmE: widget.nameOfme,
                                        nameOfUser: widget.newFullName,
                                        imageOfUser: widget.image,
                                        sendEmail: widget.userEmail,
                                        myEmail: FirebaseAuth
                                            .instance.currentUser!.email!,
                                        msg: text!);
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
