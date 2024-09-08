import 'package:flutter/material.dart';
import 'package:product_pulse/core/utils/styles.dart';
import 'package:product_pulse/core/widgets/custom_user_circle_avatar.dart';

class CommentItem extends StatelessWidget {
  const CommentItem(
      {super.key,
      required this.image,
      required this.name,
      required this.comment});
  final String image;
  final String name;
  final String comment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomUserCircleAvatar(
            userImage: image,
          ),
          const SizedBox(
            width: 8,
          ),
          Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width - 110),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
                color: Color(0xfff1f4ff)),
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Style.font18Bold(context),
                ),
                Text(
                  comment,
                  style: Style.font18Medium(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
