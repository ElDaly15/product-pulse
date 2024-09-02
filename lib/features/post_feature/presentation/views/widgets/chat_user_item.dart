import 'package:flutter/material.dart';
import 'package:product_pulse/core/utils/styles.dart';
import 'package:product_pulse/core/widgets/custom_user_circle_avatar.dart';

class ChatUserItem extends StatelessWidget {
  const ChatUserItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: const CustomUserCircleAvatar(),
      title: Text(
        'Mazen Eldaly',
        style: Style.font18Medium(context),
      ),
      subtitle: Text(
        'Hi Mazen , How Are You ?',
        style: Style.font14Medium(context).copyWith(color: Colors.grey),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
