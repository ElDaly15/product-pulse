import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:product_pulse/core/widgets/no_internet_connecition.dart';
import 'package:product_pulse/features/chat/presentation/views/chat_view.dart';
import 'package:product_pulse/features/post_feature/presentation/views/create_post_view.dart';
import 'package:product_pulse/features/post_feature/presentation/views/search_view.dart';

import 'package:product_pulse/features/post_feature/presentation/views/widgets/main_view_body.dart';
import 'package:iconly/iconly.dart';
import 'package:product_pulse/features/post_feature/presentation/views/your_posts_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

enum _SelectedTab { home, favorite, add, search, person }

class _MainViewState extends State<MainView> {
  var _selectedTab = _SelectedTab.home;

  final PageController _pageController = PageController(initialPage: 0);
  final List<Widget> pages = <Widget>[
    const MainViewBody(),
    const YourPostsView(),
    const CreatePostView(),
    const SearchView(),
    const ChatView(),
  ];

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
    });
    _pageController.jumpToPage(i);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (context, value, child) {
        final bool connection = value.first != ConnectivityResult.none;
        return connection ? child : const NoconnectionScreen();
      },
      child: Scaffold(
        extendBody: true,
        backgroundColor: const Color(0XFFFFFFFF),
        body: PageView(
          controller: _pageController,
          children: pages,
          onPageChanged: (int index) {
            setState(() {
              _selectedTab = _SelectedTab.values[index];
            });
          },
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: CrystalNavigationBar(
            enableFloatingNavBar: true,
            currentIndex: _SelectedTab.values.indexOf(_selectedTab),
            unselectedItemColor: Colors.white70,
            backgroundColor: const Color(0xff1F41BB),
            onTap: _handleIndexChanged,
            items: [
              /// Home
              CrystalNavigationBarItem(
                icon: IconlyBold.home,
                unselectedIcon: IconlyLight.home,
                selectedColor: Colors.white,
              ),

              /// Favourite
              CrystalNavigationBarItem(
                icon: IconlyBold.paper,
                unselectedIcon: IconlyLight.paper,
                selectedColor: Colors.white,
              ),

              /// Add
              CrystalNavigationBarItem(
                icon: IconlyBold.plus,
                unselectedIcon: IconlyLight.plus,
                selectedColor: Colors.white,
              ),

              /// Search
              CrystalNavigationBarItem(
                  icon: IconlyBold.search,
                  unselectedIcon: IconlyLight.search,
                  selectedColor: Colors.white),

              /// Profile
              CrystalNavigationBarItem(
                icon: IconlyBold.user_2,
                unselectedIcon: IconlyLight.user,
                selectedColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
