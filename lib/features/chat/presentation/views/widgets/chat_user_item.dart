import 'package:flutter/material.dart';
import 'package:product_pulse/core/utils/styles.dart';

class ChatUserItem extends StatelessWidget {
  const ChatUserItem({super.key, required this.onTap});

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: const SizedBox(), //CustomUserCircleAvatar(),
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
