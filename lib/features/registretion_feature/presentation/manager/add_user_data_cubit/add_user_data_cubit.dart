// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'add_user_data_state.dart';

class AddUserDataCubit extends Cubit<AddUserDataState> {
  AddUserDataCubit() : super(AddUserDataInitial());

  addUserData(
      {required String firstName,
      required String lastName,
      required String image,
      required String birthDay,
      required String birthMonth,
      required String birthYear,
      required String email,
      required String gender,
      required String bestProduct,
      required String uid}) {
    try {
      emit(AddUserDataLoading());
      CollectionReference usersData =
          FirebaseFirestore.instance.collection('usersData');

      usersData.add({
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
        'coverImage':
            'https://images.ctfassets.net/hrltx12pl8hq/28ECAQiPJZ78hxatLTa7Ts/2f695d869736ae3b0de3e56ceaca3958/free-nature-images.jpg?fit=fill&w=1200&h=630',
      });
      emit(AddUserDataSuccess());
    } catch (e) {
      emit(AddUserDataFailuer());
    }
  }
}
