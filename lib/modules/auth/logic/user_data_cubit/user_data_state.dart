part of 'user_data_cubit.dart';

@immutable
sealed class UserDataState {}

final class UserDataInitial extends UserDataState {}

final class SetUserDataLoading extends UserDataState {}

final class SetUserDataSuccess extends UserDataState {}

final class SetUserDataFailure extends UserDataState {
  final String errorMsg;

  SetUserDataFailure({required this.errorMsg});
}

//! Update User Data
final class UpdateUserDataLoading extends UserDataState {}

final class UpdateUserDataSuccess extends UserDataState {}

final class UpdateUserDataFailure extends UserDataState {
  final String errorMsg;

  UpdateUserDataFailure({required this.errorMsg});
}

//! Get User Data
final class GetUserDataLoading extends UserDataState {}

final class GetUserDataSuccess extends UserDataState {
  final UserModel userModel;
  GetUserDataSuccess({required this.userModel});
}

final class GetUserDataFailure extends UserDataState {
  final String errorMsg;
  GetUserDataFailure({required this.errorMsg});
}
