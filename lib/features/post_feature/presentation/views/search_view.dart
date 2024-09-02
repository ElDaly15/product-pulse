import 'package:flutter/material.dart';
import 'package:product_pulse/core/utils/styles.dart';
import 'package:product_pulse/core/widgets/custom_search_text_field.dart';

import 'package:product_pulse/features/post_feature/presentation/views/widgets/user_profile_item.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

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
              'Search For Any User ',
              style: Style.font22Bold(context),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 15,
            ),
          ),
          SliverToBoxAdapter(
              child: CustomSearchTextField(
                  hintTitle: 'Search ... ',
                  obscure: false,
                  onChanged: (val) {},
                  isPassword: false)),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
            ),
          ),
          SliverToBoxAdapter(
            child: Text(
              'Search Results ',
              style: Style.font22Bold(context),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 15,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Padding(
                padding: index == 3
                    ? const EdgeInsets.only(bottom: 100)
                    : const EdgeInsets.only(bottom: 16),
                child: const UserProfileItem(),
              );
            }, childCount: 4),
          ),
        ],
      ),
    );
  }
}
