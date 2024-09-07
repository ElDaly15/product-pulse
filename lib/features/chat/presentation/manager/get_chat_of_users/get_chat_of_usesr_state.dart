part of 'get_chat_of_usesr_cubit.dart';

@immutable
sealed class GetChatOfUsesrState {}

final class GetChatOfUsesrInitial extends GetChatOfUsesrState {}

final class GetChatOfUsesrLoading extends GetChatOfUsesrState {}

final class GetChatOfUsesrSuccess extends GetChatOfUsesrState {
  final List<ChatUserModel> users;

  GetChatOfUsesrSuccess({required this.users});
}

final class GetChatOfUsesrFailuer extends GetChatOfUsesrState {}
