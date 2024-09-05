part of 'get_reactions_cubit.dart';

@immutable
sealed class GetReactionsState {}

final class GetReactionsInitial extends GetReactionsState {}

final class GetReactionsSuccess extends GetReactionsState {
  final List<ReactionModel> reactionsModelList;

  GetReactionsSuccess({required this.reactionsModelList});
}

final class GetReactionsFailure extends GetReactionsState {}

final class GetReactionsLoading extends GetReactionsState {}
