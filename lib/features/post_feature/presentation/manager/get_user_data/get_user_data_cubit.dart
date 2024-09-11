import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:product_pulse/features/post_feature/data/models/user_data_model.dart';

part 'get_user_data_state.dart';

class GetUserDataCubit extends Cubit<GetUserDataState> {
  GetUserDataCubit() : super(GetUserDataInitial());

  getUserData() {
    try {
      emit(GetUserDataLoading());

      FirebaseFirestore.instance
          .collection('usersData')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots()
          .listen((querySnapshot) {
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        UserDataModel user = UserDataModel.fromJson(documentSnapshot.data()!);

        emit(GetUserDataSuccess(userDataModel: user));
      });
    } catch (e) {
      emit(GetUserDataFailuer());
    }
  }
}
