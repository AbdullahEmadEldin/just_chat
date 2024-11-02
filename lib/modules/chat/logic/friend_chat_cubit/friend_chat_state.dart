part of 'friend_chat_cubit.dart';

@immutable
sealed class FriendsChatState {}

final class AllChatsInitial extends FriendsChatState {}

final class GetChatsLoading extends FriendsChatState {}

final class GetChatsSuccess extends FriendsChatState {
  final List<ChatModel> chats;

  final List<UserModel> opponentUsers;
  final List<int> unreadMsgsCount;
  GetChatsSuccess({
    required this.chats,
    required this.opponentUsers,
    required this.unreadMsgsCount,
  });
}

final class GetChatsFailure extends FriendsChatState {
  final String error;

  GetChatsFailure({required this.error});
}
