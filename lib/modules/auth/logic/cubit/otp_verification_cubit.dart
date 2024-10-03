// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/di/dependency_injection.dart';

part 'otp_verification_state.dart';

class OtpVerificationCubit extends Cubit<OtpVerificationState> {
  OtpVerificationCubit() : super(OtpVerificationInitial());

  ///! verify OTP code
  ///
  Future<void> verifyOtp(
      {required String verificationId, required String otpCode}) async {
    emit(OtpVerificationLoading());
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId:
            verificationId, // comes from verify phone number method.
        smsCode: otpCode,
      );
      final UserCredential userCredential =
          await getIt<FirebaseAuth>().signInWithCredential(credential);
      print(
          '------------IS NEW USER----------->>>>>>>> ${userCredential.additionalUserInfo!.isNewUser}');

      /// this bool will be used to handle navigation after Otp success verification.

      emit(OtpVerificationSuccess(
          isNewUser: userCredential.additionalUserInfo!.isNewUser));
      //
    } on PlatformException catch (e) {
      emit(OtpVerificationFailure(errorMsg: e.message.toString()));
      print('OTP --------------------------->>> Fail ${e.message}');
      //
    } on FirebaseAuthException catch (e) {
      emit(OtpVerificationFailure(errorMsg: e.message.toString()));
      print(
          'OTP --------------FirebaseAuthException------------->>> Fail ${e.message}');
      //
    } catch (e) {
      emit(OtpVerificationFailure(errorMsg: e.toString()));
    }
  }
}
