// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:product_pulse/features/post_feature/data/models/reaction_model.dart';

part 'get_reactions_state.dart';

class GetReactionsCubit extends Cubit<GetReactionsState> {
  GetReactionsCubit() : super(GetReactionsInitial());

  List<ReactionModel> reactionModelList = [];

  getReactions({required String postId}) {
    try {
      emit(GetReactionsLoading());
      FirebaseFirestore.instance
          .collection('posts')
          .where('postId', isEqualTo: postId)
          .snapshots()
          .listen((querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          reactionModelList = [];
          for (var doc in querySnapshot.docs) {
            List<dynamic> likes = doc.data()['likes'] ?? [];
            for (var like in likes) {
              reactionModelList.add(ReactionModel.jsonData(like));
            }
          }
          emit(GetReactionsSuccess(reactionsModelList: reactionModelList));
        }
      });
    } catch (e) {
      emit(GetReactionsFailure());
    }
  }
}
