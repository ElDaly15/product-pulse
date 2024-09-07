import 'package:flutter/material.dart';
import 'package:product_pulse/core/utils/styles.dart';
import 'package:product_pulse/core/widgets/custom_user_circle_avatar.dart';

class ChatUserItem extends StatelessWidget {
  const ChatUserItem(
      {super.key,
      required this.onTap,
      required this.image,
      required this.name,
      required this.lastMsg});
  final String image;
  final String name;
  final String lastMsg;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CustomUserCircleAvatar(
        userImage: image,
      ),
      title: Text(
        name,
        style: Style.font18Medium(context),
      ),
      subtitle: Text(
        lastMsg,
        style: Style.font14Medium(context).copyWith(color: Colors.grey),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
