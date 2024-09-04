import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages, unnecessary_import
import 'package:meta/meta.dart';
import 'package:product_pulse/features/post_feature/presentation/views/main_view.dart';
import 'package:product_pulse/features/registretion_feature/presentation/views/start_data_view.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  loginUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      emit(LoginLoading());
      // ignore: unused_local_variable
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (FirebaseAuth.instance.currentUser!.emailVerified) {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('usersData')
            .where('email', isEqualTo: email)
            .limit(1)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          // ignore: use_build_context_synchronously
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) {
                return const MainView();
              },
            ),
          );
        } else {
          // ignore: use_build_context_synchronously
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) {
                return const StartDataView();
              },
            ),
          );
        }

        emit(LoginSuccess());
      } else {
        await FirebaseAuth.instance.currentUser!.sendEmailVerification();
        emit(LoginFailuer(
            message:
                'Please Verify Your Email to log in. A verification email has been sent.'));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailuer(message: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(LoginFailuer(message: 'Wrong password provided for that user.'));
      } else if (e.code == 'invalid-credential') {
        emit(LoginFailuer(message: 'Check Your Password And Email.'));
      } else if (e.code == 'too-many-requests') {
        emit(LoginFailuer(
            message: 'Too Many Requests Wait While And Try Again Later.'));
      }
    } catch (e) {
      emit(LoginFailuer(message: 'An Error Occurred'));
    } finally {
      Timer(const Duration(seconds: 5), () {
        emit(LoginEndLoading());
      });
    }
  }
}
