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
