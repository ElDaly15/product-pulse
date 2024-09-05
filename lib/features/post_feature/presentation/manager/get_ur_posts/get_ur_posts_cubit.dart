// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:product_pulse/features/post_feature/data/models/post_model.dart';

part 'get_ur_posts_state.dart';

class GetUrPostsCubit extends Cubit<GetUrPostsState> {
  GetUrPostsCubit() : super(GetUrPostsInitial());
  List<PostModel> posts = [];

  getUrPosts() {
    try {
      emit(GetUrPostsLoading());
      FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots()
          .listen((querySnapshot) {
        posts = querySnapshot.docs
            .map(
                // ignore: unnecessary_cast
                (doc) => PostModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList();

        emit(GetUrPostsSuccess(posts: posts));
      });
    } catch (e) {
      emit(GetUrPostsFailuer());
    }
  }
}
