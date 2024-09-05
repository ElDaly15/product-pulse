import 'package:flutter/material.dart';
import 'package:product_pulse/core/utils/styles.dart';
import 'package:product_pulse/core/widgets/custom_user_circle_avatar.dart';

class UserProfileItem extends StatelessWidget {
  const UserProfileItem(
      {super.key,
      required this.onTap,
      required this.name,
      required this.image});

  final Function()? onTap;

  final String name;
  final String image;

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
    );
  }
}
