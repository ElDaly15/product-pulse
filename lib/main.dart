import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:product_pulse/features/registretion_feature/presentation/views/start_app_view.dart';

void main() {
  runApp(DevicePreview(
      enabled: false, builder: (context) => const ProductPulseApp()));
}

class ProductPulseApp extends StatelessWidget {
  const ProductPulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      home: const StartAppView(),
    );
  }
}
