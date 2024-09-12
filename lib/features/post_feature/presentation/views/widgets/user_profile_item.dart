import 'package:flutter/material.dart';
import 'package:product_pulse/core/utils/styles.dart';
import 'package:product_pulse/core/widgets/custom_user_circle_avatar.dart';

class UserProfileItem extends StatelessWidget {
  const UserProfileItem(
      {super.key,
      required this.onTap,
      required this.name,
      required this.image,
      required this.onPressed,
      required this.iconData,
      required this.color});

  final Function()? onTap;

  final String name;
  final String image;
  final void Function()? onPressed;
  final IconData iconData;
  final Color color;

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
        icon: Icon(
          iconData,
          color: color,
        ),
      ),
    );
  }
}
