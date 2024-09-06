import 'package:flutter/material.dart';
import 'package:product_pulse/core/utils/styles.dart';
import 'package:product_pulse/features/chat/presentation/views/widgets/chat_user_item.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

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
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: 12,
              itemBuilder: (context, index) {
                return index == 11
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 100),
                        child: ChatUserItem(
                          onTap: () {
                            // Navigator.of(context)
                            //     .push(MaterialPageRoute(builder: (context) {
                            //   return const UsersChatView();
                            // }));
                          },
                        ),
                      )
                    : ChatUserItem(
                        onTap: () {
                          // Navigator.of(context)
                          //     .push(MaterialPageRoute(builder: (context) {
                          //   return const UsersChatView();
                          // }));
                        },
                      );
              },
            ),
          )
        ],
      ),
    );
  }
}
