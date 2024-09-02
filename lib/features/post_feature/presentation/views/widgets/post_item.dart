import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:product_pulse/core/utils/styles.dart';
import 'package:product_pulse/core/widgets/custom_user_circle_avatar.dart';
import 'package:product_pulse/features/post_feature/presentation/views/widgets/row_of_star_and_comments.dart';

class PostItem extends StatelessWidget {
  const PostItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        decoration: BoxDecoration(boxShadow: const [
          BoxShadow(spreadRadius: 1, blurRadius: 2, color: Colors.black26)
        ], borderRadius: BorderRadius.circular(8), color: Colors.white),
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
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(FontAwesomeIcons.ellipsis),
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
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  Text(
                    123.toString(),
                    style: Style.font14SemiBold(context),
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
