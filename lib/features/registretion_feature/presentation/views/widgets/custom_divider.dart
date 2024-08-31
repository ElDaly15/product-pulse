import 'package:flutter/material.dart';
import 'package:product_pulse/core/utils/styles.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          const Expanded(
            child: Divider(
              endIndent: 10,
              indent: 10,
              height: 2,
              color: Colors.grey,
              thickness: 1,
            ),
          ),
          Text(
            'Or Continue with',
            style: Style.font18SemiBold(context)
                .copyWith(color: const Color(0xff1F41BB)),
          ),
          const Expanded(
            child: Divider(
              endIndent: 10,
              indent: 10,
              height: 50,
              color: Colors.grey,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
