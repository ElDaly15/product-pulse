part of 'get_chat_messages_cubit.dart';

@immutable
sealed class GetChatMessagesState {}

final class GetChatMessagesInitial extends GetChatMessagesState {}

final class GetChatMessagesLoading extends GetChatMessagesState {}

final class GetChatMessagesFailuer extends GetChatMessagesState {}

final class GetChatMessagesSuccess extends GetChatMessagesState {
  final List<MsgModel> messages;

  GetChatMessagesSuccess({required this.messages});
}
