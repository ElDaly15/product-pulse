import 'package:flutter/material.dart';
import 'package:product_pulse/core/utils/styles.dart';
import 'package:product_pulse/core/widgets/custom_user_circle_avatar.dart';
import 'package:product_pulse/features/chat/presentation/views/widgets/preview_chat_user_image.dart';

class CustomUserChatIAppBar extends StatelessWidget {
  const CustomUserChatIAppBar(
      {super.key, required this.fullName, required this.image});
  final String fullName;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return PreviewChatUserImage(
                  imageUrl: image,
                  fullNameOfUser: fullName,
                );
              }));
            },
            child: CustomUserCircleAvatar(
              userImage: image,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            fullName,
            style: Style.font22SemiBold(context),
          ),
        ],
      ),
    );
  }
}
