import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:product_pulse/core/utils/images.dart';
import 'package:product_pulse/core/utils/styles.dart';
import 'package:product_pulse/features/post_feature/data/models/select_item_model.dart';
import 'package:product_pulse/features/post_feature/presentation/views/widgets/item_btn_for_tab_bar.dart';
import 'package:product_pulse/features/post_feature/presentation/views/widgets/post_item.dart';

class MainViewBody extends StatefulWidget {
  const MainViewBody({super.key});

  @override
  State<MainViewBody> createState() => _MainViewBodyState();
}

class _MainViewBodyState extends State<MainViewBody> {
  int currentIndex = 0;

  List<SelectItemModel> items = [
    SelectItemModel(iconData: FontAwesomeIcons.inbox, title: 'All Products'),
    SelectItemModel(iconData: FontAwesomeIcons.bolt, title: 'Electronics'),
    SelectItemModel(iconData: FontAwesomeIcons.mobile, title: 'Mobiles'),
    SelectItemModel(iconData: FontAwesomeIcons.laptop, title: 'Laptobs'),
    SelectItemModel(iconData: FontAwesomeIcons.shirt, title: 'Clothes'),
    SelectItemModel(iconData: FontAwesomeIcons.bootstrap, title: 'Shoes'),
    SelectItemModel(
        iconData: FontAwesomeIcons.sprayCanSparkles, title: 'Perfume'),
    SelectItemModel(iconData: FontAwesomeIcons.shuffle, title: 'Other'),
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    'Hello Jane!',
                    style: Style.font24Bold(context),
                  ),
                  Image.asset(Assets.wave),
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
                        onTap: () {
                          setState(() {
                            currentIndex = index;
                          });
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
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Padding(
                  padding: index == 9
                      ? const EdgeInsets.only(bottom: 100)
                      : const EdgeInsets.only(bottom: 16),
                  child: const PostItem(),
                );
              }, childCount: 10),
            ),
          ],
        ),
      ),
    );
  }
}
