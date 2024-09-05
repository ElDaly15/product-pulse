part of 'get_ur_posts_cubit.dart';

@immutable
sealed class GetUrPostsState {}

final class GetUrPostsInitial extends GetUrPostsState {}

final class GetUrPostsSuccess extends GetUrPostsState {
  final List<PostModel> posts;

  GetUrPostsSuccess({required this.posts});
}

final class GetUrPostsFailuer extends GetUrPostsState {}

final class GetUrPostsLoading extends GetUrPostsState {}
