import 'package:flutter/material.dart';
import 'package:product_pulse/core/utils/images.dart';
import 'package:product_pulse/features/registretion_feature/presentation/views/widgets/custom_socail_media_buttom.dart';

class CustomSocailMediaConnectRow extends StatelessWidget {
  const CustomSocailMediaConnectRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Spacer(),
        SocialMediaConnectButtom(
          onPressed: () {},
          image: Assets.imagesGoogle,
        ),
        const SizedBox(
          width: 15,
        ),
        SocialMediaConnectButtom(
          onPressed: () {},
          image: Assets.imagesFacebook,
        ),
        const SizedBox(
          width: 15,
        ),
        SocialMediaConnectButtom(
          onPressed: () {},
          image: Assets.imagesApple,
        ),
        const Spacer(),
      ],
    );
  }
}
