import 'package:flutter/material.dart';
import 'package:product_pulse/core/utils/styles.dart';
import 'package:product_pulse/core/widgets/custom_user_circle_avatar.dart';

class CustomUserChatIAppBar extends StatelessWidget {
  const CustomUserChatIAppBar({super.key});

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
          const CustomUserCircleAvatar(),
          const SizedBox(
            width: 15,
          ),
          Text(
            'Mazen Eldaly',
            style: Style.font22SemiBold(context),
          ),
        ],
      ),
    );
  }
}
