part of 'register_cubit_cubit.dart';

@immutable
sealed class RegisterCubitState {}

final class RegisterCubitInitial extends RegisterCubitState {}

final class RegisterCubitSuccess extends RegisterCubitState {}

final class RegisterCubitFailuer extends RegisterCubitState {
  final String errorMsg;

  RegisterCubitFailuer({required this.errorMsg});
}

final class RegisterCubitLoading extends RegisterCubitState {}
