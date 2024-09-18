// ignore_for_file: unnecessary_import
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:product_pulse/core/utils/styles.dart';
import 'package:product_pulse/features/post_feature/data/models/user_data_model.dart';
import 'package:product_pulse/features/post_feature/presentation/manager/get_user_profile_posts/get_user_profile_posts_cubit.dart';
import 'package:product_pulse/features/post_feature/presentation/manager/get_user_specific_data/get_user_specific_data_cubit.dart';
import 'package:product_pulse/features/post_feature/presentation/views/widgets/fakeItems.dart';
import 'package:product_pulse/features/post_feature/presentation/views/widgets/item_of_profile.dart';
import 'package:product_pulse/features/post_feature/presentation/views/widgets/post_item.dart';
import 'package:skeletonizer/skeletonizer.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView(
      {super.key,
      required this.myData,
      required this.userDataModel,
      required this.email});
  final UserDataModel myData;
  final UserDataModel userDataModel;
  final String email;
  @override
  State<UserProfileView> createState() => _MainViewBodyState();
}

class _MainViewBodyState extends State<UserProfileView> {
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
    getUserPosts();
    getUserData();
    startTime();
  }

  getUserPosts() async {
    await BlocProvider.of<GetUserProfilePostsCubit>(context)
        .getUserPosts(email: widget.email);
  }

  getUserData() async {
    await BlocProvider.of<GetUserSpecificDataCubit>(context)
        .getUserData(email: widget.email);
  }

  @override
  void dispose() {
    super.dispose();
    timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetUserSpecificDataCubit, GetUserSpecificDataState>(
      listener: (context, state) {},
      builder: (context, userstate) {
        if (userstate is GetUserSpecificDataSuccess) {
          return Scaffold(
            floatingActionButton: IconButton(
              iconSize: 30,
              style: IconButton.styleFrom(
                  backgroundColor: const Color(0xff1F41BB)),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
              color: Colors.white,
            ),
            backgroundColor: const Color(0xffffffff),
            body: ModalProgressHUD(
              inAsyncCall: isAsync,
              color: const Color(0xff1F41BB).withOpacity(0.1),
              progressIndicator: const CircularProgressIndicator(
                color: Color(0xff1F41BB),
              ),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                      child: ItemOfProfile(
                    myData: widget.myData,
                    onSubmitData: (iaLoading) {
                      isAsync = iaLoading;
                      setState(() {});
                    },
                    userDataModel: userstate.users,
                  )),
                  SliverPadding(
                    padding: const EdgeInsets.only(
                        right: 22, left: 22, top: 80, bottom: 0),
                    sliver: SliverToBoxAdapter(
                      child: Text(
                        'Posts',
                        style: Style.font20SemiBold(context),
                      ),
                    ),
                  ),
                  BlocConsumer<GetUserProfilePostsCubit,
                      GetUserProfilePostsState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is GetUserProfilePostsSuccess) {
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
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: PostItem(
                                      postTime: relativeTime,
                                      userDataModel: widget.myData,
                                      postItem: state.posts[index],
                                    ),
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
                      } else if (state is GetUserProfilePostsLoading) {
                        return SliverList(
                          delegate:
                              SliverChildBuilderDelegate((context, index) {
                            return const Fakeitemofpost();
                          }, childCount: 6),
                        );
                      } else {
                        return SliverToBoxAdapter(
                          child: Center(
                              child: Text(
                            'An Error Occuered',
                            style: Style.font18SemiBold(context),
                          )),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Scaffold(
            backgroundColor: Color(0xffffffff),
            body: Center(
                child: CircularProgressIndicator(
              color: Color(0xff1F41BB),
            )),
          );
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
