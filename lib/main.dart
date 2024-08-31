import 'package:flutter/material.dart';
import 'package:product_pulse/features/registretion_feature/presentation/views/start_app_view.dart';

void main() {
  runApp(const ProductPulseApp());
}

class ProductPulseApp extends StatelessWidget {
  const ProductPulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: StartAppView(),
    );
  }
}
