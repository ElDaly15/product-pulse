import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_pulse/core/utils/images.dart';
import 'package:product_pulse/core/widgets/custom_snack_bar.dart';
import 'package:product_pulse/features/registretion_feature/presentation/manager/google_auth/google_auth_cubit.dart';
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
          onPressed: () async {
            await BlocProvider.of<GoogleAuthCubit>(context)
                .signInWithGoogle(context: context);
          },
          image: Assets.imagesGoogle,
        ),
        const SizedBox(
          width: 15,
        ),
        SocialMediaConnectButtom(
          onPressed: () {
            CustomSnackBar().showSnackBar(context: context, msg: 'Coming Soon');
          },
          image: Assets.imagesFacebook,
        ),
        const SizedBox(
          width: 15,
        ),
        SocialMediaConnectButtom(
          onPressed: () {
            CustomSnackBar().showSnackBar(context: context, msg: 'Coming Soon');
          },
          image: Assets.imagesApple,
        ),
        const Spacer(),
      ],
    );
  }
}
