part of 'all_chats_cubit.dart';

@immutable
sealed class AllChatsState {}

final class AllChatsInitial extends AllChatsState {}

final class GetChatsLoading extends AllChatsState {}

final class GetChatsSuccess extends AllChatsState {
  final List<ChatModel> chats;

  final List<UserModel> opponentUsers;
  final List<int> unreadMsgsCount;
  GetChatsSuccess({
    required this.chats,
    required this.opponentUsers,
    required this.unreadMsgsCount,
  });
}

final class GetChatsFailure extends AllChatsState {
  final String error;

  GetChatsFailure({required this.error});
}
