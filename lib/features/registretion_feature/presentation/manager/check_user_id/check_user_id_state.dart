part of 'check_user_id_cubit.dart';

@immutable
sealed class CheckUserIdState {}

final class CheckUserIdInitial extends CheckUserIdState {}

final class CheckUserIdSuccess extends CheckUserIdState {
  final bool checkUserId;

  CheckUserIdSuccess({required this.checkUserId});
}
