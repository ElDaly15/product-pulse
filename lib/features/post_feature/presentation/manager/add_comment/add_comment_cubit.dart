// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'add_comment_state.dart';

class AddCommentCubit extends Cubit<AddCommentState> {
  AddCommentCubit() : super(AddCommentInitial());

  addComment(
      {required String postId,
      required String comment,
      required String userName,
      required String userImage}) async {
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
            'comments': FieldValue.arrayUnion([
              {
                'uid': FirebaseAuth.instance.currentUser!.uid,
                'comment': comment,
                'userName': userName,
                'userImage': userImage
              }
            ])
          })
          .then((_) => print("Document Updated"))
          .catchError((error) => print("Failed to update document: $error"));
    } else {
      print("No document found for the provided query.");
    }
  }
}
