import 'package:flutter/material.dart';
import 'package:product_pulse/features/registretion_feature/presentation/views/widgets/start_data_view_body.dart';

class StartDataView extends StatelessWidget {
  const StartDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      body: StartDataViewBody(),
    );
  }
}
