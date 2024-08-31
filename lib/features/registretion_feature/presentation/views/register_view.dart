import 'package:flutter/material.dart';
import 'package:product_pulse/features/registretion_feature/presentation/views/widgets/register_view_body.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      body: RegisterViewBody(),
    );
  }
}
