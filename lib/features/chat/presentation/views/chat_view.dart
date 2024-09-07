import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_pulse/core/utils/styles.dart';
import 'package:product_pulse/features/chat/presentation/manager/get_chat_of_users/get_chat_of_usesr_cubit.dart';
import 'package:product_pulse/features/chat/presentation/views/users_chat_view.dart';
import 'package:product_pulse/features/chat/presentation/views/widgets/chat_user_item.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  void initState() {
    super.initState();

    getUsers();
  }

  getUsers() async {
    await BlocProvider.of<GetChatOfUsesrCubit>(context)
        .getChatOfUsers(email: FirebaseAuth.instance.currentUser!.email!);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 60,
          ),
          Text(
            'Chats',
            style: Style.font22Bold(context),
          ),
          BlocConsumer<GetChatOfUsesrCubit, GetChatOfUsesrState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is GetChatOfUsesrSuccess) {
                if (state.users.isEmpty) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        'No Users Now , Go Search and Start Chatting',
                        style: Style.font18Bold(context),
                      ),
                    ),
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: state.users.length,
                      itemBuilder: (context, index) {
                        return index == state.users.length - 1
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 100),
                                child: ChatUserItem(
                                  name: state.users[index].name,
                                  image: state.users[index].image,
                                  lastMsg: state.users[index].lastMsg,
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return UsersChatView(
                                        fullName: state.users[index].name,
                                        name: state.users[index].name,
                                        userEmail: state.users[index].email,
                                        image: state.users[index].image,
                                      );
                                    }));
                                  },
                                ),
                              )
                            : ChatUserItem(
                                name: state.users[index].name,
                                image: state.users[index].image,
                                lastMsg: state.users[index].lastMsg,
                                onTap: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return UsersChatView(
                                      fullName: state.users[index].name,
                                      name: state.users[index].name,
                                      userEmail: state.users[index].email,
                                      image: state.users[index].image,
                                    );
                                  }));
                                },
                              );
                      },
                    ),
                  );
                }
              } else if (state is GetChatOfUsesrLoading) {
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Color(0XFF1F41BB),
                    ),
                  ),
                );
              } else {
                return Expanded(
                  child: Center(
                    child: Text(
                      'An Error Occured',
                      style: Style.font18Bold(context),
                    ),
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
