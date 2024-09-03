import 'package:flutter/material.dart';
import 'package:product_pulse/core/utils/styles.dart';

class CustomAppBarForBackBtn extends StatelessWidget {
  const CustomAppBarForBackBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        Text(
          'Settings',
          style: Style.font22SemiBold(context),
        )
      ],
    );
  }
}
