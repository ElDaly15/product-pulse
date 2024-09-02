import 'package:flutter/material.dart';
import 'package:product_pulse/core/utils/styles.dart';
import 'package:product_pulse/features/post_feature/presentation/views/widgets/post_item.dart';

class YourPostsView extends StatelessWidget {
  const YourPostsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 60,
            ),
          ),
          SliverToBoxAdapter(
            child: Text(
              'Your Posts',
              style: Style.font24Bold(context),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Padding(
                padding: index == 3
                    ? const EdgeInsets.only(bottom: 100)
                    : const EdgeInsets.only(bottom: 16),
                child: const PostItem(),
              );
            }, childCount: 4),
          ),
        ],
      ),
    );
  }
}
