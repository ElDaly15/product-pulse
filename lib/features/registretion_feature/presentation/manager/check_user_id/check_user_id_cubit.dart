// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'check_user_id_state.dart';

class CheckUserIdCubit extends Cubit<CheckUserIdState> {
  CheckUserIdCubit() : super(CheckUserIdInitial());

  Future<bool> checkUserId(String userId) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('usersData')
        .where('uid', isEqualTo: userId)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      emit(CheckUserIdSuccess(checkUserId: true));
      return true;
    }
    emit(CheckUserIdSuccess(checkUserId: false));
    return false;
  }
}
