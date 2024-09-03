import 'package:flutter/material.dart';
import 'package:product_pulse/core/utils/styles.dart';
import 'package:product_pulse/core/widgets/custom_user_circle_avatar.dart';

class UserProfileItem extends StatelessWidget {
  const UserProfileItem({super.key, required this.onTap});

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: const CustomUserCircleAvatar(),
      title: Text(
        'Mazen Eldaly',
        style: Style.font18Medium(context),
      ),
    );
  }
}
