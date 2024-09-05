import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_pulse/core/utils/styles.dart';

import 'package:product_pulse/features/post_feature/presentation/manager/get_reactions/get_reactions_cubit.dart';
import 'package:product_pulse/features/post_feature/presentation/views/widgets/settings_app_bar.dart';
import 'package:product_pulse/features/post_feature/presentation/views/widgets/user_profile_item.dart';

class ReactionsView extends StatefulWidget {
  const ReactionsView({super.key, required this.potsId});
  final String potsId;
  @override
  State<ReactionsView> createState() => _ReactionsViewState();
}

class _ReactionsViewState extends State<ReactionsView> {
  @override
  void initState() {
    super.initState();
    getReactions();
  }

  getReactions() async {
    await BlocProvider.of<GetReactionsCubit>(context)
        .getReactions(postId: widget.potsId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          children: [
            const SafeArea(child: SizedBox()),
            const CustomAppBarForBackBtn(
              title: 'People Who Reacted',
            ),
            BlocConsumer<GetReactionsCubit, GetReactionsState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is GetReactionsSuccess) {
                  if (state.reactionsModelList.isEmpty) {
                    return Center(
                        child: Text(
                      'No Reactions For This Post Now',
                      style: Style.font18Bold(context),
                    ));
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: state.reactionsModelList.length,
                        itemBuilder: (context, index) {
                          return UserProfileItem(
                            image: state.reactionsModelList[index].image,
                            name: state.reactionsModelList[index].name,
                            onTap: () {},
                          );
                        },
                      ),
                    );
                  }
                } else if (state is GetReactionsFailure) {
                  return Center(
                    child: Text('An Error Occured , Try Again Later',
                        style: Style.font18Bold(context)),
                  );
                } else {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Color(0xff1F41BB),
                  ));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
