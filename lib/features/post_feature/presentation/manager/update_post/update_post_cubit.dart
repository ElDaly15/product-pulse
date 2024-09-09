import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'update_post_state.dart';

class UpdatePostCubit extends Cubit<UpdatePostState> {
  UpdatePostCubit() : super(UpdatePostInitial());

  updatePost({
    required String firstName,
    required String lastName,
    required String title,
    required String category,
    required String postId,
    required String image,
    required String userImage,
    required String userId,
    required String userEmail,
    required Timestamp postTime,
    required List<dynamic> likes,
    required List<dynamic> comments,
  }) async {
    try {
      emit(UpdatePostLoading());
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance // Get Data You Want To Update First
              .collection('posts')
              .where('postId', isEqualTo: postId)
              .limit(1)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        DocumentReference docRef = documentSnapshot.reference;

        await docRef
            .update({
              'title': title,
              'category': category,
              'image': image,
              'firstName': firstName,
              'lastName': lastName,
              'userImage': userImage,
              'userId': userId,
              'userEmail': userEmail,
              'postTime': postTime,
              'postId': postId,
              'likes': likes,
              'comments': comments
            })
            .then((_) => emit(UpdatePostSuccess()))
            .catchError((error) => emit(UpdatePostFailuer()));
      } else {
        // ignore: avoid_print
        print("No document found for the provided query.");
      }
      // ignore: empty_catches, unused_catch_clause
    } on Exception catch (e) {}
  }
}
