import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:product_pulse/features/post_feature/data/models/post_model.dart';

part 'get_posts_state.dart';

class GetPostsCubit extends Cubit<GetPostsState> {
  StreamSubscription<QuerySnapshot>? _subscription;

  GetPostsCubit() : super(GetPostsInitial());

  List<PostModel> posts = [];

  void getPosts() {
    _subscription?.cancel();
    emit(GetPostsLoading());
    _subscription = FirebaseFirestore.instance
        .collection('posts')
        .snapshots()
        .listen((querySnapshot) {
      posts = querySnapshot.docs
          .map((doc) => PostModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      emit(GetPostsSuccess(posts: posts));
    }, onError: (error) {
      emit(GetPostsFailuer());
    });
  }

  void getPostsForCategory({required String category}) {
    _subscription?.cancel();
    emit(GetPostsLoading());
    _subscription = FirebaseFirestore.instance
        .collection('posts')
        .where('category', isEqualTo: category)
        .snapshots()
        .listen((querySnapshot) {
      posts = querySnapshot.docs
          .map((doc) => PostModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      emit(GetPostsSuccess(posts: posts));
    }, onError: (error) {
      emit(GetPostsFailuer());
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
