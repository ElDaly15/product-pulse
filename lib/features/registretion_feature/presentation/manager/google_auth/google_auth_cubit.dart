// ignore_for_file: unnecessary_import, depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:product_pulse/features/post_feature/presentation/views/main_view.dart';
import 'package:product_pulse/features/registretion_feature/presentation/views/start_data_view.dart';

part 'google_auth_state.dart';

class GoogleAuthCubit extends Cubit<GoogleAuthState> {
  GoogleAuthCubit() : super(GoogleAuthInitial());

  Future<void> signInWithGoogle({required BuildContext context}) async {
    // Trigger the authentication flow
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        return;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('usersData')
          .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
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
      // ignore: empty_catches
    } catch (e) {}
  }
}
