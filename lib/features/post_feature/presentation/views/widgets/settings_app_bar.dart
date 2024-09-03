import 'package:flutter/material.dart';
import 'package:product_pulse/core/utils/styles.dart';

class CustomAppBarForBackBtn extends StatelessWidget {
  const CustomAppBarForBackBtn({super.key, required this.title});
  final String title;

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
          title,
          style: Style.font22SemiBold(context),
        )
      ],
    );
  }
}
