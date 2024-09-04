import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_pulse/features/registretion_feature/presentation/manager/register_cubit/register_cubit_cubit.dart';

import 'package:product_pulse/features/registretion_feature/presentation/views/start_app_view.dart';
import 'package:product_pulse/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(DevicePreview(
      enabled: false, builder: (context) => const ProductPulseApp()));
}

class ProductPulseApp extends StatelessWidget {
  const ProductPulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubitCubit(),
      child: MaterialApp(
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        home: const StartAppView(),
      ),
    );
  }
}
