import 'package:flutter/material.dart';
import 'package:product_pulse/features/registretion_feature/presentation/views/widgets/custom_start_app_body.dart';

class StartAppView extends StatelessWidget {
  const StartAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      body: CustomStartAppBody(),
    );
  }
}
