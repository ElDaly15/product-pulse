part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginSuccess extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginEndLoading extends LoginState {}

final class LoginFailuer extends LoginState {
  final String message;

  LoginFailuer({required this.message});
}
