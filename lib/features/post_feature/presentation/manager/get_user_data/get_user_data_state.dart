part of 'get_user_data_cubit.dart';

@immutable
sealed class GetUserDataState {}

final class GetUserDataInitial extends GetUserDataState {}

final class GetUserDataSuccess extends GetUserDataState {
  final UserDataModel userDataModel;

  GetUserDataSuccess({required this.userDataModel});
}

final class GetUserDataFailuer extends GetUserDataState {}

final class GetUserDataLoading extends GetUserDataState {}
