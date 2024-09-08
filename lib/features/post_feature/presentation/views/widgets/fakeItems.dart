// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:product_pulse/core/utils/images.dart';
import 'package:product_pulse/core/utils/styles.dart';
import 'package:product_pulse/features/post_feature/data/models/post_model.dart';
import 'package:product_pulse/features/post_feature/data/models/user_data_model.dart';
import 'package:product_pulse/features/post_feature/presentation/views/widgets/post_item.dart';
import 'package:product_pulse/features/registretion_feature/presentation/views/start_app_view.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Fakeitemofpost extends StatelessWidget {
  const Fakeitemofpost({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: PostItem(
        userDataModel: UserDataModel(
            firstName: '1',
            lastName: '1',
            image: Assets.imageOfStartUser,
            uid: '1',
            email: '1',
            bestProduct: '1',
            birthDay: '1',
            birthMonth: '1',
            birthYear: '1',
            gender: '1',
            fullName: '1'),
        postItem: PostModel(
            firstName: '1',
            lastName: '1',
            postId: '12',
            userImage: Assets.imageOfStartUser,
            timestamp: Timestamp.now(),
            title: '1',
            likes: [],
            comments: [],
            userEmail: '1',
            userId: '1',
            image: Assets.imageOfStartUser),
        postTime: '2022',
      ),
    );
  }
}

class FakeStart extends StatelessWidget {
  const FakeStart({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Hello Mazen ',
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
          Text(
            'Let\'s Find Your Favourite Product',
            style: Style.font18SemiBold(context),
          ),
        ],
      ),
    );
  }
}
