import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:product_pulse/features/post_feature/data/models/user_data_model.dart';

part 'get_user_specific_data_state.dart';

class GetUserSpecificDataCubit extends Cubit<GetUserSpecificDataState> {
  GetUserSpecificDataCubit() : super(GetUserSpecificDataInitial());

  getUserData({required String email}) {
    try {
      emit(GetUserSpecificDataLoading());

      FirebaseFirestore.instance
          .collection('usersData')
          .where('email', isEqualTo: email)
          .snapshots()
          .listen((querySnapshot) {
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        UserDataModel user = UserDataModel.fromJson(documentSnapshot.data()!);

        emit(GetUserSpecificDataSuccess(users: user));
      });
    } catch (e) {
      emit(GetUserSpecificDataFailuer());
    }
  }
}
