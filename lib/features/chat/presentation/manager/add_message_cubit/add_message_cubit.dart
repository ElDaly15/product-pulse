// ignore_for_file: unnecessary_brace_in_string_interps, unused_local_variable, avoid_print

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'add_message_state.dart';

class AddMessageCubit extends Cubit<AddMessageState> {
  AddMessageCubit() : super(AddMessageInitial());

  Future<void> sendMessage(
      {required String sendEmail,
      required String myEmail,
      required String msg,
      required String imageOfUser,
      required String nameOfUser}) async {
    if (myEmail == sendEmail) {
      QuerySnapshot querySnapshot = await FirebaseFirestore
          .instance // To Get A Data To Email or anything you want
          .collection(myEmail)
          .where('email', isEqualTo: sendEmail)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        CollectionReference messages =
            FirebaseFirestore.instance.collection('messages');
        messages.add({
          'msg': msg,
          'id': '${myEmail}-${sendEmail}',
          'sender': myEmail,
          'reciever': sendEmail,
          'SendAt': DateTime.now(),
        });
      }

      QuerySnapshot updateSnapshot =
          await FirebaseFirestore.instance // Get Data You Want To Update First
              .collection(myEmail)
              .where('email', isEqualTo: sendEmail)
              .limit(1)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        DocumentReference docRef = documentSnapshot.reference;

        await docRef
            .update({'lastMsg': msg})
            .then((_) => print("Document Updated"))
            .catchError((error) => print("Failed to update document: $error"));
      } else {
        FirebaseFirestore.instance.collection(myEmail).add({
          'email': sendEmail,
          'lastMsg': msg,
          'imageOfUser': imageOfUser,
          'userNameOfUser': nameOfUser
        });
        CollectionReference messages =
            FirebaseFirestore.instance.collection('messages');
        messages.add({
          'msg': msg,
          'id': '${myEmail}-${sendEmail}',
          'sender': myEmail,
          'reciever': sendEmail,
          'SendAt': DateTime.now(),
        });
      }
    } else {
      emit(AddMessageLoading());
      QuerySnapshot querySnapshot = await FirebaseFirestore
          .instance // To Get A Data To Email or anything you want
          .collection(myEmail)
          .where('email', isEqualTo: sendEmail)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        CollectionReference messages =
            FirebaseFirestore.instance.collection('messages');
        messages.add({
          'msg': msg,
          'id': '${myEmail}-${sendEmail}',
          'sender': myEmail,
          'reciever': sendEmail,
          'SendAt': DateTime.now(),
        });

        // ignore: duplicate_ignore
        // ignore: unused_local_variable
        QuerySnapshot updateSnapshot = await FirebaseFirestore
            .instance // Get Data You Want To Update First
            .collection(myEmail)
            .where('email', isEqualTo: sendEmail)
            .limit(1)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
          DocumentReference docRef = documentSnapshot.reference;

          await docRef
              .update({'lastMsg': msg})
              .then((_) => print("Document Updated"))
              .catchError(
                  (error) => print("Failed to update document: $error"));
        }
      } else {
        FirebaseFirestore.instance.collection(myEmail).add({
          'email': sendEmail,
          'lastMsg': msg,
          'imageOfUser': imageOfUser,
          'userNameOfUser': nameOfUser
        });
        CollectionReference messages =
            FirebaseFirestore.instance.collection('messages');
        messages.add({
          'msg': msg,
          'id': '${myEmail}-${sendEmail}',
          'sender': myEmail,
          'reciever': sendEmail,
          'SendAt': DateTime.now(),
        });
      }

      QuerySnapshot newSnapshotUser = await FirebaseFirestore
          .instance // To Get A Data To Email or anything you want
          .collection(sendEmail)
          .where('email', isEqualTo: myEmail)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        FirebaseFirestore.instance.collection(sendEmail).add({
          'email': myEmail,
          'lastMsg': msg,
          'imageOfUser': imageOfUser,
          'userNameOfUser': nameOfUser
        });
      }

      emit(AddMessageSuccess());
    }
  }
}
