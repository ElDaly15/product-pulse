import 'package:flutter/material.dart';
import 'package:product_pulse/features/registretion_feature/presentation/views/widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      body: LoginViewBody(),
    );
  }
}
