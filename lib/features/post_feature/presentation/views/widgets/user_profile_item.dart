import 'package:flutter/material.dart';
import 'package:product_pulse/core/utils/styles.dart';
import 'package:product_pulse/core/widgets/custom_user_circle_avatar.dart';

class UserProfileItem extends StatelessWidget {
  const UserProfileItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: const CustomUserCircleAvatar(),
      title: Text(
        'Mazen Eldaly',
        style: Style.font18Medium(context),
      ),
    );
  }
}
