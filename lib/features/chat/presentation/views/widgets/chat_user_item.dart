import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:product_pulse/core/utils/styles.dart';
import 'package:product_pulse/core/widgets/custom_user_circle_avatar.dart';

class ChatUserItem extends StatelessWidget {
  const ChatUserItem({
    super.key,
    required this.onTap,
    required this.image,
    required this.name,
    required this.lastMsg,
    required this.lastMsgTime,
  });

  final String image;
  final String name;
  final String lastMsg;
  final Function()? onTap;
  final Timestamp? lastMsgTime; // Allow null values here

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat.jm(); // Updated format to include AM/PM
    final dateTime =
        // ignore: prefer_null_aware_operators
        lastMsgTime != null ? lastMsgTime!.toDate() : null; // Check for null

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
      trailing: dateTime != null
          ? Text(
              dateFormat.format(dateTime), // Formats with AM/PM
              style: Style.font14Medium(context),
            )
          : Text(
              'N/A', // Placeholder for null time values
              style: Style.font14Medium(context).copyWith(color: Colors.grey),
            ),
    );
  }
}
