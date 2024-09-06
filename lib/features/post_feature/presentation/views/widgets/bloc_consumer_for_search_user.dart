// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_pulse/core/utils/styles.dart';
import 'package:product_pulse/features/chat/presentation/views/users_chat_view.dart';
import 'package:product_pulse/features/post_feature/presentation/manager/search_users/search_cubit.dart';
import 'package:product_pulse/features/post_feature/presentation/views/widgets/user_profile_item.dart';

class blocConsumerForSearchUser extends StatelessWidget {
  const blocConsumerForSearchUser({
    super.key,
    required this.textSearch,
  });

  final String textSearch;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchUsesrCubit, SearchUserState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is SearchUserSuccess) {
          if (textSearch.isEmpty) {
            state.users.clear();
          }
          if (state.users.isEmpty) {
            return SliverToBoxAdapter(
              child: textSearch.isEmpty
                  ? Center(
                      child: Text(
                      'Start Search For Users',
                      style: Style.font18Bold(context),
                    ))
                  : Center(
                      child: Text(
                      'No Users Available',
                      style: Style.font18Bold(context),
                    )),
            );
          } else {
            return SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return UserProfileItem(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return UsersChatView(
                        name: state.users[index].fullName,
                      );
                    }));
                  },
                  name: state.users[index].fullName,
                  image: state.users[index].image,
                );
              }, childCount: state.users.length),
            );
          }
        } else if (state is SearchUserLoading) {
          return const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(
                color: Color(0xff1F41BB),
              ),
            ),
          );
        } else if (state is SearchUserFailure) {
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
              'Start Search For Users',
              style: Style.font18Bold(context),
            ),
          ));
        }
      },
    );
  }
}
