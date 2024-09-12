part of 'get_user_specific_data_cubit.dart';

@immutable
sealed class GetUserSpecificDataState {}

final class GetUserSpecificDataInitial extends GetUserSpecificDataState {}

final class GetUserSpecificDataSuccess extends GetUserSpecificDataState {
  final UserDataModel users;

  GetUserSpecificDataSuccess({required this.users});
}

final class GetUserSpecificDataFailuer extends GetUserSpecificDataState {}

final class GetUserSpecificDataLoading extends GetUserSpecificDataState {}
