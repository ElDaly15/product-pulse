part of 'search_posts_cubit.dart';

@immutable
sealed class SearchPostsState {}

final class SearchPostsInitial extends SearchPostsState {}

final class SearchPostsSuccess extends SearchPostsState {
  final List<PostModel> posts;

  SearchPostsSuccess({required this.posts});
}

final class SearchPostsFailuer extends SearchPostsState {}

final class SearchPostsLoading extends SearchPostsState {}
