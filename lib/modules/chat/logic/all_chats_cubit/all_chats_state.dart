part of 'all_chats_cubit.dart';

@immutable
sealed class AllChatsState {}

final class AllChatsInitial extends AllChatsState {}

final class GettingOppUserInfoLoading extends AllChatsState {}

final class GettingOppUserInfoSuccess extends AllChatsState {}

final class GettingOppUserInfoFailure extends AllChatsState {}
