// ignore_for_file: depend_on_referenced_packages, unnecessary_cast

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:product_pulse/features/post_feature/data/models/post_model.dart';

part 'search_posts_state.dart';

class SearchPostsCubit extends Cubit<SearchPostsState> {
  SearchPostsCubit() : super(SearchPostsInitial());
  List<PostModel> posts = [];
  Future<void> searchPosts({required String postTitle}) async {
    try {
      emit(SearchPostsLoading());
      posts = [];
      FirebaseFirestore.instance
          .collection('posts')
          .snapshots()
          .listen((querySnapshot) {
        posts = querySnapshot.docs
            .map(
                (doc) => PostModel.fromJson(doc.data() as Map<String, dynamic>))
            .where((user) =>
                user.title.toLowerCase().contains(postTitle.toLowerCase()))
            .toList();

        emit(SearchPostsSuccess(posts: posts));
      });
    } catch (e) {
      emit(SearchPostsFailuer());
    }
  }
}
