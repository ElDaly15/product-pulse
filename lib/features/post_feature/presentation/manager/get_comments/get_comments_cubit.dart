// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:product_pulse/features/post_feature/data/models/comment_model.dart';

part 'get_comments_state.dart';

class GetCommentsCubit extends Cubit<GetCommentsState> {
  GetCommentsCubit() : super(GetCommentsInitial());
  List<CommentModel> comments = [];
  getComments({required String postId}) {
    try {
      emit(GetCommentsLoading());
      FirebaseFirestore.instance
          .collection('posts')
          .where('postId', isEqualTo: postId)
          .snapshots()
          .listen((querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          comments = [];

          for (var doc in querySnapshot.docs) {
            List<dynamic> allComments = doc.data()['comments'] ?? [];
            for (var comment in allComments) {
              comments.add(CommentModel.jsonData(comment));
            }
          }
          emit(GetCommentsSuccess(comments: comments));
        }
      });
    } catch (e) {
      emit(GetCommentsFailuer());
    }
  }

  Future<void> editComment({
    required String postId,
    required String commentId,
    required Map<String, dynamic> updatedCommentData,
  }) async {
    try {
      // Fetch the document containing the post
      var postDoc = await FirebaseFirestore.instance
          .collection('posts')
          .where('postId', isEqualTo: postId)
          .get();

      if (postDoc.docs.isNotEmpty) {
        var doc = postDoc.docs.first;

        // Get the current comments list
        List<dynamic> allComments = doc.data()['comments'] ?? [];

        // Find the comment to be edited using commentId
        for (int i = 0; i < allComments.length; i++) {
          if (allComments[i]['commentId'] == commentId) {
            allComments[i] =
                updatedCommentData; // Replace with updated comment data
            break;
          }
        }

        // Update the document with the modified comments list
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(doc.id)
            .update({'comments': allComments});

        emit(GetCommentsSuccess(comments: comments));
      }
    } catch (e) {
      emit(GetCommentsFailuer());
    }
  }
}
