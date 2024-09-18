import 'package:flutter/material.dart';
import 'package:product_pulse/core/utils/images.dart';
import 'package:product_pulse/core/utils/styles.dart';
import 'package:product_pulse/features/registretion_feature/presentation/views/widgets/custom_row_of_start_app_buttoms.dart';

class CustomStartAppBody extends StatelessWidget {
  const CustomStartAppBody({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              child: SizedBox(
                height: height * 0.05,
              ),
            ),
            AspectRatio(
              aspectRatio: 1 / 1,
              child: Center(
                child: Image.asset(
                  Assets.imagesVectorLogin,
                  width: width * 0.7,
                ),
              ),
            ),
            Text(
              'Discover Your',
              textAlign: TextAlign.center,
              style: Style.font22SemiBold(context)
                  .copyWith(fontSize: 30, color: const Color(0xff1F41BB)),
            ),
            Text(
              'Favorite Products Here',
              textAlign: TextAlign.center,
              style: Style.font22SemiBold(context)
                  .copyWith(fontSize: 25, color: const Color(0xff1F41BB)),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Text(
              'Explore all the existing products and check the product based on pepole reviews and don\'t take any risk again',
              textAlign: TextAlign.center,
              style: Style.font14Regular(context),
            ),
            SizedBox(
              height: height * 0.06,
            ),
            const CustomRowOfStartAppButtoms(),
          ],
        ),
      ),
    );
  }
}
