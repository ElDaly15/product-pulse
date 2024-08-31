import 'package:flutter/material.dart';
import 'package:product_pulse/features/registretion_feature/presentation/views/login_view.dart';
import 'package:product_pulse/features/registretion_feature/presentation/views/widgets/custom_start_app_buttom.dart';

class CustomRowOfStartAppButtoms extends StatelessWidget {
  const CustomRowOfStartAppButtoms({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomStartAppButtom(
          colorId: 0xff1F41BB,
          colorText: 0xffffffff,
          text: 'Login',
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return const LoginView();
                },
              ),
            );
          },
        ),
        CustomStartAppButtom(
          colorId: 0xffffffff,
          colorText: 0xff0A0A0A,
          text: 'Register',
          onPressed: () {},
        ),
      ],
    );
  }
}
