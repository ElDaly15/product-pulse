// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:product_pulse/core/utils/images.dart';
import 'package:product_pulse/features/post_feature/data/models/post_model.dart';
import 'package:product_pulse/features/post_feature/data/models/user_data_model.dart';
import 'package:product_pulse/features/post_feature/presentation/views/widgets/post_item.dart';
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
