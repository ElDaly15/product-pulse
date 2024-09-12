import 'package:flutter/material.dart';
import 'package:product_pulse/core/utils/styles.dart';
import 'package:product_pulse/core/widgets/custom_user_circle_avatar.dart';

class UserProfileItem extends StatelessWidget {
  const UserProfileItem(
      {super.key,
      required this.onTap,
      required this.name,
      required this.image,
      required this.onPressed});

  final Function()? onTap;

  final String name;
  final String image;
  final void Function()? onPressed;

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
      trailing: IconButton(
        onPressed: onPressed,
        icon: const Icon(
          Icons.person,
          color: Colors.black,
        ),
      ),
    );
  }
}
