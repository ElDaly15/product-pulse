// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:product_pulse/features/chat/data/models/chat_user_model.dart';

part 'get_chat_of_usesr_state.dart';

class GetChatOfUsesrCubit extends Cubit<GetChatOfUsesrState> {
  GetChatOfUsesrCubit() : super(GetChatOfUsesrInitial());
  List<ChatUserModel> dataUserModelList = [];

  Future<void> getChatOfUsers({required String email}) async {
    try {
      emit(GetChatOfUsesrLoading());
      FirebaseFirestore.instance
          .collection(email)
          .snapshots()
          .listen((querySnapshot) {
        dataUserModelList = querySnapshot.docs
            .map((doc) =>
                // ignore: unnecessary_cast
                ChatUserModel.jsonData(doc.data() as Map<String, dynamic>))
            .toList();
        emit(GetChatOfUsesrSuccess(users: dataUserModelList));
      });
    } catch (e) {
      emit(GetChatOfUsesrFailuer());
    }
  }
}
