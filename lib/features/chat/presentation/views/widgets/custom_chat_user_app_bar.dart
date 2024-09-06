import 'package:flutter/material.dart';
import 'package:product_pulse/core/utils/styles.dart';

class CustomUserChatIAppBar extends StatelessWidget {
  const CustomUserChatIAppBar({super.key, required this.fullName});
  final String fullName;

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
          const SizedBox(), // CustomUserCircleAvatar(),
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
