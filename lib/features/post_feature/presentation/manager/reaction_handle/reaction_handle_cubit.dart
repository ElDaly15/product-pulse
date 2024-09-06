// ignore_for_file: avoid_print, empty_catches

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'reaction_handle_state.dart';

class ReactionHandleCubit extends Cubit<ReactionHandleState> {
  ReactionHandleCubit() : super(ReactionHandleInitial());

  addReaction({
    required String postId,
    required String name,
    required String userImage,
  }) async {
    try {
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
              'likes': FieldValue.arrayUnion([
                {
                  'uid': FirebaseAuth.instance.currentUser!.uid,
                  'name': name,
                  'image': userImage
                }
              ])
            })
            .then((_) => print('done'))
            .catchError((error) => print("Failed to update document: $error"));
      } else {
        print("No document found for the provided query.");
      }
    } catch (e) {}
  }

  deleteReaction({
    required String postId,
    required String name,
    required String userImage,
  }) async {
    try {
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
              'likes': FieldValue.arrayRemove([
                {
                  'uid': FirebaseAuth.instance.currentUser!.uid,
                  'name': name,
                  'image': userImage
                }
              ])
            })
            .then((_) => print('done'))
            .catchError((error) => print("Failed to update document: $error"));
      } else {
        print("No document found for the provided query.");
      }
    } catch (e) {}
  }
}
