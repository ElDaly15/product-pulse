import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:product_pulse/core/utils/styles.dart';

import 'package:product_pulse/features/post_feature/data/models/user_data_model.dart';
import 'package:product_pulse/features/post_feature/presentation/manager/get_posts/get_posts_cubit.dart';
import 'package:product_pulse/features/post_feature/presentation/manager/get_ur_posts/get_ur_posts_cubit.dart';
import 'package:product_pulse/features/post_feature/presentation/manager/get_user_data/get_user_data_cubit.dart';

import 'package:product_pulse/features/post_feature/presentation/views/widgets/post_item.dart';

class YourPostsView extends StatefulWidget {
  const YourPostsView({super.key});

  @override
  State<YourPostsView> createState() => _MainViewBodyState();
}

class _MainViewBodyState extends State<YourPostsView> {
  int currentIndex = 0;
  bool isAsync = false;

  UserDataModel? user;
  Timer? timer;

  void startTime() {
    timer = Timer.periodic(const Duration(minutes: 1), (time) {
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    getMyPosts();
    startTime();
  }

  getMyPosts() async {
    await BlocProvider.of<GetUrPostsCubit>(context).getUrPosts();
  }

  @override
  void dispose() {
    super.dispose();
    timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUserDataCubit, GetUserDataState>(
      builder: (context, userState) {
        if (userState is GetUserDataSuccess) {
          return ModalProgressHUD(
            inAsyncCall: isAsync,
            color: const Color(0xff1F41BB).withOpacity(0.1),
            progressIndicator: const CircularProgressIndicator(
              color: Color(0xff1F41BB),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                      child: SizedBox(
                    height: 60,
                  )),
                  SliverToBoxAdapter(
                    child: Text(
                      'Your Posts',
                      style: Style.font20SemiBold(context),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 20,
                    ),
                  ),
                  BlocConsumer<GetPostsCubit, GetPostsState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is GetPostsSuccess) {
                        if (state.posts.isNotEmpty) {
                          return SliverList(
                            delegate:
                                SliverChildBuilderDelegate((context, index) {
                              final timestamp = state.posts[index].timestamp;

                              if (timestamp != null) {
                                final dateTime = timestamp.toDate();
                                final relativeTime =
                                    formatTimeDifference(dateTime);
                                return Padding(
                                  padding: index == state.posts.length - 1
                                      ? const EdgeInsets.only(bottom: 100)
                                      : const EdgeInsets.only(bottom: 16),
                                  child: PostItem(
                                    postTime: relativeTime,
                                    userDataModel: userState.userDataModel,
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
                        } else {
                          return SliverToBoxAdapter(
                            child: Center(
                              child: Text(
                                'No Posts Available Now',
                                style: Style.font18Bold(context),
                              ),
                            ),
                          );
                        }
                      } else if (state is GetPostsLoading) {
                        return const SliverToBoxAdapter(
                            child: Center(
                                child: CircularProgressIndicator(
                          color: Color(0xff1F41BB),
                        )));
                      } else {
                        return const SliverToBoxAdapter(
                          child: Text('An Error Occuered'),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(
              child: CircularProgressIndicator(
            color: Color(0xff1F41BB),
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
