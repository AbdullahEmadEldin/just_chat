part of 'all_chats_cubit.dart';

@immutable
sealed class AllChatsState {}

final class AllChatsInitial extends AllChatsState {}

final class AllChatsLoading extends AllChatsState {}

/// This state will be used to cancel loading state in case of success get chats stream which will be returned from method.
final class AllChatsLoaded extends AllChatsState {}

final class AllChatsFailure extends AllChatsState {
  final String message;

  AllChatsFailure({required this.message});
}
