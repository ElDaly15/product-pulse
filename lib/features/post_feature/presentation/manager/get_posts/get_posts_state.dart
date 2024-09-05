part of 'get_posts_cubit.dart';

@immutable
sealed class GetPostsState {}

final class GetPostsInitial extends GetPostsState {}

final class GetPostsSuccess extends GetPostsState {
  final List<PostModel> posts;

  GetPostsSuccess({required this.posts});
}

final class GetPostsFailuer extends GetPostsState {}

final class GetPostsLoading extends GetPostsState {}
