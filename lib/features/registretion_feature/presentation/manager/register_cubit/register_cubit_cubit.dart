import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: unnecessary_import, depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:product_pulse/core/widgets/custom_snack_bar.dart';
import 'package:product_pulse/features/registretion_feature/presentation/views/login_view.dart';

part 'register_cubit_state.dart';

class RegisterCubitCubit extends Cubit<RegisterCubitState> {
  RegisterCubitCubit() : super(RegisterCubitInitial());

  registerNewUser(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      emit(RegisterCubitLoading());
      // ignore: unused_local_variable
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      CustomSnackBar().showSnackBar(
          // ignore: use_build_context_synchronously
          context: context,
          msg: 'Register Done Successfully,Please Verify Your Email');
      emit(RegisterCubitEndLoading());
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();

      bool isVerify = false;

      while (!isVerify) {
        await Future.delayed(const Duration(seconds: 3));
        await FirebaseAuth.instance.currentUser!.reload();
        isVerify = FirebaseAuth.instance.currentUser!.emailVerified;
      }

      if (isVerify) {
        emit(RegisterCubitSuccess());
      } else {
        // ignore: use_build_context_synchronously
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return const LoginView();
        }));
      }

      emit(RegisterCubitSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterCubitFailuer(
            errorMsg: 'The password provided is too weak'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterCubitFailuer(
            errorMsg: FirebaseAuth.instance.currentUser!.emailVerified
                ? 'The account already exists for that email.'
                : 'The account already exists for that email, But Need To Verify'));
      }
    } catch (e) {
      emit(RegisterCubitFailuer(errorMsg: 'Something went wrong'));
    }
    Timer(const Duration(seconds: 5), () {
      emit(RegisterCubitEndLoading());
    });
  }
}
