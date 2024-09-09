part of 'update_post_cubit.dart';

@immutable
sealed class UpdatePostState {}

final class UpdatePostInitial extends UpdatePostState {}

final class UpdatePostSuccess extends UpdatePostState {}

final class UpdatePostFailuer extends UpdatePostState {}

final class UpdatePostLoading extends UpdatePostState {}
