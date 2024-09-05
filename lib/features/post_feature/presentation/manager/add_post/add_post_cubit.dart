// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'add_post_state.dart';

class AddPostCubit extends Cubit<AddPostState> {
  AddPostCubit() : super(AddPostInitial());
  var uuid = const Uuid();
  addPost({
    required String firstName,
    required String lastName,
    required String title,
    required String category,
    required String image,
    required String userImage,
    required String userId,
    required String userEmail,
  }) {
    try {
      emit(AddPostLoading());
      CollectionReference posts =
          FirebaseFirestore.instance.collection('posts');

      posts.add({
        'title': title,
        'category': category,
        'image': image,
        'firstName': firstName,
        'lastName': lastName,
        'userImage': userImage,
        'userId': userId,
        'userEmail': userEmail,
        'postTime': FieldValue.serverTimestamp(),
        'postId': uuid.v4(),
        'likes': [],
        'comments': []
      });
      emit(AddPostSuccess());
    } catch (e) {
      emit(AddPostFailuer());
    }
  }
}
