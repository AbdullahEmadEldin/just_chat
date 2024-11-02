part of 'all_chats_cubit.dart';

@immutable
sealed class AllChatsState {}

final class AllChatsInitial extends AllChatsState {}

//! UI Control states

final class SwitchBetweenChatTypes extends AllChatsState {
  final ChatType chatType;
  SwitchBetweenChatTypes({required this.chatType});
}