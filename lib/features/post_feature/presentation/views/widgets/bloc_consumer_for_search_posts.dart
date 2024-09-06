// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:product_pulse/core/utils/styles.dart';
import 'package:product_pulse/features/post_feature/data/models/user_data_model.dart';
import 'package:product_pulse/features/post_feature/presentation/manager/search_posts/search_posts_cubit.dart';

import 'package:product_pulse/features/post_feature/presentation/views/widgets/post_item.dart';

class blocConsumerForSearchPosts extends StatelessWidget {
  const blocConsumerForSearchPosts(
      {super.key, required this.textSearch, required this.userModel});

  final String textSearch;
  final UserDataModel userModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchPostsCubit, SearchPostsState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is SearchPostsSuccess) {
          if (textSearch.isEmpty) {
            state.posts.clear();
          }
          if (state.posts.isEmpty) {
            return SliverToBoxAdapter(
              child: textSearch.isEmpty
                  ? Center(
                      child: Text(
                      'Start Search For Products',
                      style: Style.font18Bold(context),
                    ))
                  : Center(
                      child: Text(
                      'No Products Available',
                      style: Style.font18Bold(context),
                    )),
            );
          } else {
            return SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final timestamp = state.posts[index].timestamp;
                if (timestamp != null) {
                  final dateTime = timestamp.toDate();
                  final relativeTime = formatTimeDifference(dateTime);
                  return Padding(
                    padding: index == state.posts.length - 1
                        ? const EdgeInsets.only(bottom: 100)
                        : const EdgeInsets.only(bottom: 16),
                    child: PostItem(
                      postTime: relativeTime,
                      userDataModel: userModel,
                      postItem: state.posts[index],
                    ),
                  );
                } else {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Center(
                        child: CircularProgressIndicator(
                      color: Color(0xff1F41BB),
                    )),
                  );
                }
              }, childCount: state.posts.length),
            );
          }
        } else if (state is SearchPostsLoading) {
          return const SliverToBoxAdapter(
            child: CircularProgressIndicator(
              color: Color(0xff1F41BB),
            ),
          );
        } else if (state is SearchPostsFailuer) {
          return SliverToBoxAdapter(
            child: Center(
                child: Text(
              'An Error Occurred',
              style: Style.font18Bold(context),
            )),
          );
        } else {
          return SliverToBoxAdapter(
              child: Center(
            child: Text(
              'Start Search For Products',
              style: Style.font18Bold(context),
            ),
          ));
        }
      },
    );
  }
}

String formatTimeDifference(DateTime? postTime) {
  if (postTime == null) return 'Unknown time';

  final now = DateTime.now();
  final difference = now.difference(postTime);

  if (difference.inDays >= 3) {
    // Format as date if 3 days or more
    final dateFormat = DateFormat('d MMM'); // e.g., 6 Apr
    return dateFormat.format(postTime);
  } else if (difference.inDays == 2) {
    return '2 days ago';
  } else if (difference.inDays == 1) {
    return '1 day ago';
  } else if (difference.inHours > 0) {
    return '${difference.inHours} hours ago';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes} minutes ago';
  } else {
    return 'Just now';
  }
}
