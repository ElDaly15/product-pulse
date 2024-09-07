part of 'add_message_cubit.dart';

@immutable
sealed class AddMessageState {}

final class AddMessageInitial extends AddMessageState {}

final class AddMessageLoading extends AddMessageState {}

final class AddMessageSuccess extends AddMessageState {}

final class AddMessageFailuer extends AddMessageState {}
