part of 'search_cubit.dart';

@immutable
sealed class SearchUserState {}

final class SearchUserInitial extends SearchUserState {}

final class SearchUserSuccess extends SearchUserState {
  final List<UserDataModel> users;

  SearchUserSuccess({required this.users});
}

final class SearchUserFailure extends SearchUserState {}

final class SearchUserLoading extends SearchUserState {}
