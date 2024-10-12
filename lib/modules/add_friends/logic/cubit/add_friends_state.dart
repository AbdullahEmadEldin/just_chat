part of 'add_friends_cubit.dart';

@immutable
sealed class AddFriendsState {}

final class AddFriendsInitial extends AddFriendsState {}

final class SearchForFriendsLoading extends AddFriendsState {}

final class SearchForFriendsSuccess extends AddFriendsState {
  final List<UserModel> usersResults;

  SearchForFriendsSuccess(this.usersResults);
}

final class SearchForFriendsFailure extends AddFriendsState {

  final String errorMsg;

  SearchForFriendsFailure({required this.errorMsg});

}
