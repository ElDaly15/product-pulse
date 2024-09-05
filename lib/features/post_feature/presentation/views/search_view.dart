import 'package:flutter/material.dart';
import 'package:product_pulse/core/utils/styles.dart';
import 'package:product_pulse/core/widgets/custom_search_text_field.dart';
import 'package:product_pulse/features/post_feature/data/models/select_item_model.dart';
import 'package:product_pulse/features/post_feature/presentation/views/widgets/item_btn_for_tab_bar.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 70,
            ),
          ),
          SliverToBoxAdapter(
            child: Text(
              'Select Search Type ',
              style: Style.font22Bold(context),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 10,
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    index = 0;
                    setState(() {});
                  },
                  child: ItemBtn(
                    isChecked: index == 0,
                    selectItemModel:
                        SelectItemModel(title: 'Users', iconData: Icons.person),
                  ),
                ),
                InkWell(
                  onTap: () {
                    index = 1;
                    setState(() {});
                  },
                  child: ItemBtn(
                    isChecked: index == 1,
                    selectItemModel: SelectItemModel(
                        title: 'Products', iconData: Icons.shopify_sharp),
                  ),
                ),
              ],
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
          index == 0
              ? SliverToBoxAdapter(
                  child: Text(
                    'Search For Any User ',
                    style: Style.font22Bold(context),
                  ),
                )
              : SliverToBoxAdapter(
                  child: Text(
                    'Search For Any Product ',
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
            delegate: SliverChildBuilderDelegate((context, i) {
              return Padding(
                padding: i == 3
                    ? const EdgeInsets.only(bottom: 100)
                    : const EdgeInsets.only(bottom: 16),
                child: index == 0
                    ? const SizedBox() //UserProfileItem(
                    //   onTap: () {
                    //     Navigator.of(context)
                    //         .push(MaterialPageRoute(builder: (context) {
                    //       return const UsersChatView();
                    //     }));
                    //   },
                    // )
                    : const Text('1'), //PostItem(),
              );
            }, childCount: 4),
          ),
        ],
      ),
    );
  }
}
