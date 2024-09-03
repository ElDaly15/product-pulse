import 'package:flutter/material.dart';
import 'package:product_pulse/core/utils/styles.dart';
import 'package:product_pulse/core/widgets/custom_user_circle_avatar.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomUserCircleAvatar(),
          const SizedBox(
            width: 8,
          ),
          Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width - 110),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: const Color(0xfff1f4ff)),
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mazen Eldaly',
                  style: Style.font18Bold(context),
                ),
                Text(
                  'Good Product I Recommended it for you , I Bought this from bostan Mall in down town , egypt last year , and still work good with me , i rate this product 9/10',
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
