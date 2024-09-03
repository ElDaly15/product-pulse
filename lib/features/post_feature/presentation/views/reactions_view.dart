import 'package:flutter/material.dart';
import 'package:product_pulse/features/post_feature/presentation/views/widgets/settings_app_bar.dart';
import 'package:product_pulse/features/post_feature/presentation/views/widgets/user_profile_item.dart';

class ReactionsView extends StatelessWidget {
  const ReactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          children: [
            const SafeArea(child: SizedBox()),
            const CustomAppBarForBackBtn(
              title: 'People Who Reacted',
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 12,
                itemBuilder: (context, index) {
                  return UserProfileItem(
                    onTap: () {},
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
