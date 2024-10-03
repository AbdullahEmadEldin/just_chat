part of 'auth_cubit.dart';

@immutable
sealed class PhoneAuthState {}

final class PhoneAuthInitial extends PhoneAuthState {}

//! Phone number verification states

final class SubmitNumberLoading extends PhoneAuthState {}

final class SubmitNumberSuccess extends PhoneAuthState {}

final class SubmitNumberFailure extends PhoneAuthState {
  final String errorMsg;

  SubmitNumberFailure({required this.errorMsg});
}


