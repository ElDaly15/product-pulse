// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:product_pulse/features/chat/data/models/MsgModel.dart';

part 'get_chat_messages_state.dart';

class GetChatMessagesCubit extends Cubit<GetChatMessagesState> {
  GetChatMessagesCubit() : super(GetChatMessagesInitial());
  List<MsgModel> messages = [];
  Future<void> getMessage(
      {required String email, required String sendEmail}) async {
    try {
      emit(GetChatMessagesLoading());
      FirebaseFirestore.instance
          .collection('messages')
          .where('id',
              // ignore: unnecessary_brace_in_string_interps
              whereIn: ['${email}-${sendEmail}', '${sendEmail}-${email}'])
          .orderBy('SendAt', descending: true)
          .snapshots()
          .listen((querySnapshot) {
            messages = querySnapshot.docs.map((doc) =>
                // ignore: unnecessary_cast
                MsgModel.jsonData(doc.data() as Map<String, dynamic>)).toList();
            emit(GetChatMessagesSuccess(messages: messages));
          });
    } catch (e) {
      emit(GetChatMessagesFailuer());
    }
  }
}
