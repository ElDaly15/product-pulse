// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'update_user_data_state.dart';

class UpdateUserDataCubit extends Cubit<UpdateUserDataState> {
  UpdateUserDataCubit() : super(UpdateUserDataInitial());

  updateUserData({
    required String uid,
    required String firstName,
    required String lastName,
    required String image,
    required String birthDay,
    required String birthMonth,
    required String birthYear,
    required String gender,
    required String bestProduct,
    required String email,
    required String coverImage,
  }) async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance // Get Data You Want To Update First
            .collection('usersData')
            .where('uid', isEqualTo: uid)
            .limit(1)
            .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
      DocumentReference docRef = documentSnapshot.reference;

      await docRef
          .update({
            'firstName': firstName,
            'lastName': lastName,
            'image': image,
            'birthDay': birthDay,
            'birthMonth': birthMonth,
            'birthYear': birthYear,
            'Gender': gender,
            'bestProduct': bestProduct,
            'email': email,
            'uid': uid,
            'fullName': '$firstName $lastName',
            'coverImage': coverImage,
          })
          .then((_) => print("Document Updated"))
          .catchError((error) => print("Failed to update document: $error"));
    } else {
      print("No document found for the provided query.");
    }
  }

  updateImage({
    required String uid,
    required String image,
  }) async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance // Get Data You Want To Update First
            .collection('usersData')
            .where('uid', isEqualTo: uid)
            .limit(1)
            .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
      DocumentReference docRef = documentSnapshot.reference;

      await docRef
          .update({
            'image': image,
          })
          .then((_) => print("Document Updated"))
          .catchError((error) => print("Failed to update document: $error"));
    } else {
      print("No document found for the provided query.");
    }
  }

  updatePostImage({
    required String uid,
    required String image,
  }) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('posts')
        .where('userId', isEqualTo: uid)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      for (var documentSnapshot in querySnapshot.docs) {
        DocumentReference docRef = documentSnapshot.reference;

        await docRef
            .update({
              'userImage': image,
            })
            .then((_) => print("Document Updated for post ID: ${docRef.id}"))
            .catchError((error) => print("Failed to update document: $error"));
      }
    } else {
      print("No documents found for the provided query.");
    }
  }
}
