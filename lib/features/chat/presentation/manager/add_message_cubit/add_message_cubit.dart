import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'add_message_state.dart';

class AddMessageCubit extends Cubit<AddMessageState> {
  AddMessageCubit() : super(AddMessageInitial());

  Future<void> sendMessage({
    required String sendEmail,
    required String myEmail,
    required String msg,
    required String imageOfmE,
    required String nameOfmE,
    required String imageOfUser,
    required String nameOfUser,
  }) async {
    try {
      emit(AddMessageLoading());

      // Check if the conversation exists for the current user
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(myEmail)
          .where('email', isEqualTo: sendEmail)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        await _updateLastMessage(querySnapshot, msg);
      } else {
        await _addNewMessage(myEmail, sendEmail, msg, imageOfUser, nameOfUser);
      }

      // Add message to the message collection
      await _addMessageToCollection(myEmail, sendEmail, msg);

      // Check if the conversation exists for the recipient
      QuerySnapshot newSnapshotUser = await FirebaseFirestore.instance
          .collection(sendEmail)
          .where('email', isEqualTo: myEmail)
          .limit(1)
          .get();

      if (newSnapshotUser.docs.isNotEmpty) {
        await _updateLastMessage(newSnapshotUser, msg);
      } else {
        await _addNewMessage(sendEmail, myEmail, msg, imageOfmE, nameOfmE);
      }

      emit(AddMessageSuccess());
    } catch (error) {
      emit(AddMessageFailuer());
    }
  }

  Future<void> _updateLastMessage(
      QuerySnapshot snapshot, String lastMessage) async {
    DocumentSnapshot documentSnapshot = snapshot.docs.first;
    DocumentReference docRef = documentSnapshot.reference;

    await docRef.update({'lastMsg': lastMessage});
  }

  Future<void> _addNewMessage(String userEmail, String otherEmail, String msg,
      String imageOfUser, String nameOfUser) async {
    FirebaseFirestore.instance.collection(userEmail).add({
      'email': otherEmail,
      'lastMsg': msg,
      'imageOfUser': imageOfUser,
      'userNameOfUser': nameOfUser
    });
  }

  Future<void> _addMessageToCollection(
      String sender, String receiver, String msg) async {
    FirebaseFirestore.instance.collection('messages').add({
      'msg': msg,
      // ignore: unnecessary_brace_in_string_interps
      'id': '${sender}-${receiver}',
      'sender': sender,
      'reciever': receiver,
      'SendAt': DateTime.now(),
    });
  }
}
