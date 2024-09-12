import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:product_pulse/features/post_feature/data/models/post_model.dart';

part 'get_user_profile_posts_state.dart';

class GetUserProfilePostsCubit extends Cubit<GetUserProfilePostsState> {
  GetUserProfilePostsCubit() : super(GetUserProfilePostsInitial());

  List<PostModel> posts = [];
  getUserPosts({required String email}) {
    try {
      emit(GetUserProfilePostsLoading());

      FirebaseFirestore.instance
          .collection('posts')
          .where('userEmail', isEqualTo: email)
          .orderBy('postTime', descending: true)
          .snapshots()
          .listen((querySnapshot) {
        posts = querySnapshot.docs
            .map(
                // ignore: unnecessary_cast
                (doc) => PostModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList();

        emit(GetUserProfilePostsSuccess(posts: posts));
      });
    } catch (e) {
      emit(GetUserProfilePostsFailuer());
    }
  }
}
