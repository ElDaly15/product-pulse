import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:product_pulse/features/post_feature/data/models/user_data_model.dart';

part 'get_user_data_state.dart';

class GetUserDataCubit extends Cubit<GetUserDataState> {
  GetUserDataCubit() : super(GetUserDataInitial());

  getUserData() async {
    try {
      emit(GetUserDataLoading());
      QuerySnapshot querySnapshot = await FirebaseFirestore
          .instance // To Get A Data To Email or anything you want
          .collection('usersData')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        UserDataModel user = UserDataModel.fromJson(documentSnapshot.data()!);

        emit(GetUserDataSuccess(userDataModel: user));
      }
    } catch (e) {
      emit(GetUserDataFailuer());
    }
  }
}
