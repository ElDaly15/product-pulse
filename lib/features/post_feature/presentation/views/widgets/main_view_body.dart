import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:product_pulse/core/utils/images.dart';
import 'package:product_pulse/core/utils/styles.dart';
import 'package:product_pulse/features/post_feature/data/models/select_item_model.dart';
import 'package:product_pulse/features/post_feature/data/models/user_data_model.dart';
import 'package:product_pulse/features/post_feature/presentation/manager/get_posts/get_posts_cubit.dart';
import 'package:product_pulse/features/post_feature/presentation/manager/get_user_data/get_user_data_cubit.dart';
import 'package:product_pulse/features/post_feature/presentation/views/widgets/fakeItems.dart';
import 'package:product_pulse/features/post_feature/presentation/views/widgets/item_btn_for_tab_bar.dart';
import 'package:product_pulse/features/post_feature/presentation/views/widgets/post_item.dart';
import 'package:product_pulse/features/registretion_feature/presentation/views/start_app_view.dart';

class MainViewBody extends StatefulWidget {
  const MainViewBody({super.key});

  @override
  State<MainViewBody> createState() => _MainViewBodyState();
}

class _MainViewBodyState extends State<MainViewBody> {
  int currentIndex = 0;
  bool isAsync = false;

  UserDataModel? user;
  String currentCategory = 'All Products';
  Timer? timer;

  List<SelectItemModel> items = [
    SelectItemModel(iconData: FontAwesomeIcons.inbox, title: 'All Products'),
    SelectItemModel(iconData: FontAwesomeIcons.bolt, title: 'Electronics'),
    SelectItemModel(iconData: FontAwesomeIcons.mobile, title: 'Mobiles'),
    SelectItemModel(iconData: FontAwesomeIcons.laptop, title: 'Laptops'),
    SelectItemModel(iconData: FontAwesomeIcons.shirt, title: 'Clothes'),
    SelectItemModel(iconData: FontAwesomeIcons.shoePrints, title: 'Shoes'),
    SelectItemModel(
        iconData: FontAwesomeIcons.sprayCanSparkles, title: 'Perfume'),
    SelectItemModel(iconData: FontAwesomeIcons.shuffle, title: 'Other'),
  ];

  @override
  void initState() {
    super.initState();
    getUserData();
    getAllProducts();

    startTime();
  }

  void startTime() {
    timer = Timer.periodic(const Duration(minutes: 1), (time) {
      setState(() {});
    });
  }

  getUserData() async {
    await BlocProvider.of<GetUserDataCubit>(context).getUserData();
  }

  getAllProducts() async {
    BlocProvider.of<GetPostsCubit>(context).getPosts();
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
              child: DefaultTabController(
                length: 6,
                child: CustomScrollView(
                  slivers: [
                    const SliverToBoxAdapter(
                        child: SizedBox(
                      height: 60,
                    )),
                    SliverToBoxAdapter(
                      child: Row(
                        children: [
                          Text(
                            'Hello ${userState.userDataModel.firstName}',
                            style: Style.font24Bold(context),
                          ),
                          Image.asset(Assets.wave),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                GoogleSignIn googleSignIn = GoogleSignIn();
                                googleSignIn.disconnect();
                                FirebaseAuth.instance.signOut();
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const StartAppView();
                                    },
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.logout,
                                color: Colors.black,
                              ))
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Text(
                        'Let\'s Find Your Favourite Product',
                        style: Style.font18SemiBold(context),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 20,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 45,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    currentIndex = index;
                                  });
                                  if (items[currentIndex].title ==
                                      'All Products') {
                                    BlocProvider.of<GetPostsCubit>(context)
                                        .getPosts();
                                  } else {
                                    BlocProvider.of<GetPostsCubit>(context)
                                        .getPostsForCategory(
                                            category: items[index].title);
                                  }
                                },
                                child: ItemBtn(
                                  selectItemModel: items[index],
                                  isChecked: index == currentIndex,
                                ),
                              ),
                            );
                          },
                        ),
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
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: Color(0xff1F41BB),
                                    ),
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
                          return SliverList(
                            delegate:
                                SliverChildBuilderDelegate((context, index) {
                              return const Fakeitemofpost();
                            }, childCount: 6),
                          );
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
            ),
          );
        } else {
          return Padding(
              padding: const EdgeInsets.all(22.0),
              child: ListView.builder(
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return const Fakeitemofpost();
                  }));
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
