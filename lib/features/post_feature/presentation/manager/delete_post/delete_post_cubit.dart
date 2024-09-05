// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'delete_post_state.dart';

class DeletePostCubit extends Cubit<DeletePostState> {
  DeletePostCubit() : super(DeletePostInitial());

  deletePost({required String postId}) async {
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
          .delete()
          .then((_) => print("Document Deleted"))
          .catchError((error) => print("Failed to Delete document: $error"));
    } else {
      print("No document found for the provided query.");
    }
  }
}
