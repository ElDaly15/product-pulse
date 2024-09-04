import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:product_pulse/core/widgets/no_internet_connecition.dart';
import 'package:product_pulse/features/registretion_feature/presentation/views/widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (context, value, child) {
        final bool connection = value.first != ConnectivityResult.none;
        return connection ? child : const NoconnectionScreen();
      },
      child: const Scaffold(
        backgroundColor: Color(0xffFFFFFF),
        body: LoginViewBody(),
      ),
    );
  }
}
