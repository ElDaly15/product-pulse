part of 'add_post_cubit.dart';

@immutable
sealed class AddPostState {}

final class AddPostInitial extends AddPostState {}

final class AddPostSuccess extends AddPostState {}

final class AddPostFailuer extends AddPostState {}

final class AddPostLoading extends AddPostState {}
