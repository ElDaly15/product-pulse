import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:product_pulse/core/utils/styles.dart';
import 'package:product_pulse/core/widgets/custom_search_text_field.dart';

import 'package:product_pulse/features/post_feature/data/models/select_item_model.dart';
import 'package:product_pulse/features/post_feature/presentation/manager/get_user_data/get_user_data_cubit.dart';
import 'package:product_pulse/features/post_feature/presentation/manager/search_posts/search_posts_cubit.dart';
import 'package:product_pulse/features/post_feature/presentation/manager/search_users/search_cubit.dart';
import 'package:product_pulse/features/post_feature/presentation/views/widgets/bloc_consumer_for_search_posts.dart';
import 'package:product_pulse/features/post_feature/presentation/views/widgets/bloc_consumer_for_search_user.dart';
import 'package:product_pulse/features/post_feature/presentation/views/widgets/item_btn_for_tab_bar.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController textEditingController = TextEditingController();
  int index = 0;
  String textSearch = '';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUserDataCubit, GetUserDataState>(
      builder: (context, userState) {
        if (userState is GetUserDataSuccess) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: CustomScrollView(slivers: [
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
                        textEditingController.clear();
                        textSearch = '';
                        setState(() {});
                      },
                      child: ItemBtn(
                        isChecked: index == 0,
                        selectItemModel: SelectItemModel(
                            title: 'Users', iconData: Icons.person),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        index = 1;
                        textSearch = '';
                        textEditingController.clear();
                        setState(() {});
                      },
                      child: ItemBtn(
                        isChecked: index == 1,
                        selectItemModel: SelectItemModel(
                            title: 'Products',
                            iconData: FontAwesomeIcons.bagShopping),
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
              SliverToBoxAdapter(
                child: index == 0
                    ? Text(
                        'Search For Any User ',
                        style: Style.font22Bold(context),
                      )
                    : Text(
                        'Search For Any Product ',
                        style: Style.font22Bold(context),
                      ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 15,
                ),
              ),
              index == 0
                  ? SliverToBoxAdapter(
                      child: CustomSearchTextField(
                          hintTitle: 'Search Users',
                          obscure: false,
                          onChanged: (user) {
                            textSearch = user;
                            setState(() {});
                            BlocProvider.of<SearchUsesrCubit>(context)
                                .searchUsers(userName: user);
                          },
                          isPassword: false,
                          textEditingController: textEditingController),
                    )
                  : SliverToBoxAdapter(
                      child: CustomSearchTextField(
                          hintTitle: 'Search Products',
                          obscure: false,
                          onChanged: (product) {
                            textSearch = product;
                            BlocProvider.of<SearchPostsCubit>(context)
                                .searchPosts(postTitle: product);
                            setState(() {});
                          },
                          isPassword: false,
                          textEditingController: textEditingController),
                    ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 10,
                ),
              ),
              SliverToBoxAdapter(
                child: Text(
                  'Results',
                  style: Style.font22Bold(context),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 10,
                ),
              ),
              index == 0
                  ? blocConsumerForSearchUser(
                      textSearch: textSearch,
                      userDataModel: userState.userDataModel,
                    )
                  : blocConsumerForSearchPosts(
                      textSearch: textSearch,
                      userModel: userState.userDataModel,
                    )
            ]),
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
