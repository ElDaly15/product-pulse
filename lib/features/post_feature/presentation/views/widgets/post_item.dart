import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:product_pulse/core/utils/styles.dart';
import 'package:product_pulse/core/widgets/custom_user_circle_avatar.dart';
import 'package:product_pulse/features/post_feature/presentation/views/reactions_view.dart';
import 'package:product_pulse/features/post_feature/presentation/views/widgets/row_of_star_and_comments.dart';

enum Menu { contact, remove }

class PostItem extends StatefulWidget {
  const PostItem({super.key});

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  AnimationStyle? _animationStyle;

  @override
  void initState() {
    super.initState();
    _animationStyle = AnimationStyle(
      curve: Easing.emphasizedDecelerate,
      duration: const Duration(seconds: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        decoration: BoxDecoration(
            boxShadow: const [],
            borderRadius: BorderRadius.circular(8),
            color: Colors.white),
        child: Column(
          children: [
            ListTile(
              leading: const CustomUserCircleAvatar(),
              title: Text(
                'Mazen Eldaly',
                style: Style.font18Medium(context),
              ),
              subtitle: const Row(
                children: [
                  Text('5h ago'),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    FontAwesomeIcons.earthAmericas,
                    size: 15,
                  ),
                ],
              ),
              trailing: PopupMenuButton<Menu>(
                surfaceTintColor: const Color(0xffffffff),
                popUpAnimationStyle: _animationStyle,
                icon: const Icon(Icons.more_vert),
                onSelected: (Menu item) {},
                itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                  PopupMenuItem<Menu>(
                    value: Menu.contact,
                    child: ListTile(
                      leading: const Icon(Icons.message_outlined),
                      title: Text(
                        'Chat With',
                        style: Style.font14SemiBold(context),
                      ),
                    ),
                  ),
                  PopupMenuItem<Menu>(
                    value: Menu.remove,
                    child: ListTile(
                      leading: const Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                      ),
                      title: Text(
                        'Remove Post',
                        style: Style.font14SemiBold(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 16, left: 16, bottom: 16, top: 4),
              child: Text(
                'This is my laptop , i need some help to make sure thats good for me or not pls help me This is my laptop , i need some help to make sure thats good for me or not pls help me ',
                style: Style.font18Medium(context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 16, left: 16, bottom: 16, top: 4),
              child: CachedNetworkImage(
                width: double.infinity,
                fit: BoxFit.fill,
                imageUrl:
                    'https://m.media-amazon.com/images/I/71ehzrGUO7L._AC_SL1500_.jpg',
                scale: 1,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xff1F41BB),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                  size: 40,
                  color: Color(0xff1F41BB),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 16, left: 16, bottom: 16, top: 4),
              child: Row(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      InkWell(
                        splashColor: Colors.green,
                        splashFactory: InkRipple.splashFactory,
                        autofocus: true,
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return const ReactionsView();
                          }));
                        },
                        child: Text(
                          123.toString(),
                          style: Style.font14SemiBold(context),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text('8 Comments', style: Style.font14SemiBold(context)),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
              endIndent: 20,
              indent: 20,
            ),
            const RowOfStarAndComments(),
          ],
        ),
      ),
    );
  }
}
