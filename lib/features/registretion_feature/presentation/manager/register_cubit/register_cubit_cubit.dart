import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_cubit_state.dart';

class RegisterCubitCubit extends Cubit<RegisterCubitState> {
  RegisterCubitCubit() : super(RegisterCubitInitial());

  registerNewUser({required String email, required String password}) async {
    try {
      emit(RegisterCubitLoading());
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(RegisterCubitSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterCubitFailuer(
            errorMsg: 'The password provided is too weak'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterCubitFailuer(
            errorMsg: 'The account already exists for that email.'));
      }
    } catch (e) {
      emit(RegisterCubitFailuer(errorMsg: 'Something went wrong'));
    }
    emit(RegisterCubitEndLoading());
  }
}
