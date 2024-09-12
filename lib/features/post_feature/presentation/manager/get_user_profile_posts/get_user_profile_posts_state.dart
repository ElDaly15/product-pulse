part of 'get_user_profile_posts_cubit.dart';

@immutable
sealed class GetUserProfilePostsState {}

final class GetUserProfilePostsInitial extends GetUserProfilePostsState {}

final class GetUserProfilePostsSuccess extends GetUserProfilePostsState {
  final List<PostModel> posts;

  GetUserProfilePostsSuccess({required this.posts});
}

final class GetUserProfilePostsFailuer extends GetUserProfilePostsState {}

final class GetUserProfilePostsLoading extends GetUserProfilePostsState {}
