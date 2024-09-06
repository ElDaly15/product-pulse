// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import 'package:product_pulse/features/post_feature/data/models/user_data_model.dart';

part 'search_state.dart';

class SearchUsesrCubit extends Cubit<SearchUserState> {
  SearchUsesrCubit() : super(SearchUserInitial());

  List<UserDataModel> users = [];

  Future<void> searchUsers({required String userName}) async {
    try {
      emit(SearchUserLoading());
      users = [];
      FirebaseFirestore.instance
          .collection('usersData')
          .snapshots()
          .listen((querySnapshot) {
        users = querySnapshot.docs
            .map((doc) =>
                // ignore: unnecessary_cast
                UserDataModel.fromJson(doc.data() as Map<String, dynamic>))
            .where((user) =>
                user.fullName.toLowerCase().contains(userName.toLowerCase()))
            .toList();

        emit(SearchUserSuccess(users: users));
      });
    } catch (e) {
      emit(SearchUserFailure());
    }
  }
}
