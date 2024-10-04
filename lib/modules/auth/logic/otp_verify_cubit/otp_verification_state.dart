part of 'otp_verification_cubit.dart';

@immutable
sealed class OtpVerificationState {}

final class OtpVerificationInitial extends OtpVerificationState {}

final class OtpVerificationLoading extends OtpVerificationState {}

final class OtpVerificationSuccess extends OtpVerificationState {
  final bool isNewUser;
  OtpVerificationSuccess({required this.isNewUser});
}

final class OtpVerificationFailure extends OtpVerificationState {
  final String errorMsg;
  OtpVerificationFailure({required this.errorMsg});
}