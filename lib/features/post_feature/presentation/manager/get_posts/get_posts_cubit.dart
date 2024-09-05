// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:product_pulse/features/post_feature/data/models/post_model.dart';

part 'get_posts_state.dart';

class GetPostsCubit extends Cubit<GetPostsState> {
  GetPostsCubit() : super(GetPostsInitial());

  List<PostModel> posts = [];

  getPosts() {
    try {
      emit(GetPostsLoading());
      FirebaseFirestore.instance
          .collection('posts')
          .orderBy('postTime', descending: true)
          .snapshots()
          .listen((querySnapshot) {
        posts = querySnapshot.docs
            .map(
                // ignore: unnecessary_cast
                (doc) => PostModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList();

        emit(GetPostsSuccess(posts: posts));
      });
    } catch (e) {
      emit(GetPostsFailuer());
    }
  }

  getPostsForCategory({required String category}) {
    posts = [];
    try {
      emit(GetPostsLoading());
      FirebaseFirestore.instance
          .collection('posts')
          .orderBy('postTime', descending: true)
          .where('category', isEqualTo: category)
          .snapshots()
          .listen((querySnapshot) {
        posts = querySnapshot.docs
            .map(
                // ignore: unnecessary_cast
                (doc) => PostModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList();

        emit(GetPostsSuccess(posts: posts));
      });
    } catch (e) {
      emit(GetPostsFailuer());
    }
  }
}
