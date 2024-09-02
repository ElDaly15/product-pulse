import 'package:flutter/material.dart';
import 'package:product_pulse/core/utils/styles.dart';

class RowOfStarAndComments extends StatelessWidget {
  const RowOfStarAndComments({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffffffff), elevation: 0),
          onPressed: () {},
          child: Row(
            children: [
              const Icon(
                Icons.star,
                color: Colors.black,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                'Star',
                style: Style.font18Medium(context),
              ),
            ],
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffffffff), elevation: 0),
          onPressed: () {},
          child: Row(
            children: [
              const Icon(
                Icons.chat,
                color: Colors.black,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                'Comments',
                style: Style.font18Medium(context),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
