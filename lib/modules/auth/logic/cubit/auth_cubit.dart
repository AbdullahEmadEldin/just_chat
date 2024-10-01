// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  PhoneAuthCubit() : super(PhoneAuthInitial());

  ///

  final formKey = GlobalKey<FormFieldState>();
  String phoneNumber = '';
  final _instance = FirebaseAuth.instance;
  String verificationId = '';

  ///! Identify Phone number on firebase and send SMS code
  ///
  Future<void> verifyPhoneNumber() async {
    emit(SubmitNumberLoading());
    await _instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: _verificationCompleted,
      verificationFailed: _verificationFailed,
      codeSent: _codeSent,
      codeAutoRetrievalTimeout: _codeAutoRetrievalTimeout,
    );
  }

  ///! verify OTP code
  ///
  Future<void> verifyOtp(String otpCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otpCode);

    await _instance.signInWithCredential(credential);
  }

  //! log out
  ///
  Future<void> logOut() async {
    await _instance.signOut();
  }

  //! get user info.
  ///
  User getUserInfo() {
    return _instance.currentUser!;
  }

  ///-----------------------------------------
  /// Private methods helpers to make code readable
  /// Call backs of verify phone number.
  /// ----------------------------------------

  ///? Automatic handling of the SMS code on Android devices
  /// Firebase sends a code via SMS message to the phone number,
  /// where you must then prompt the user to enter the code.
  /// The code can be combined with the verification ID to create a [PhoneAuthProvider.credential]
  /// which you can then use to sign the user in
  _verificationCompleted(PhoneAuthCredential credential) async {
    try {
      /// In case of success verification of OTP code the resulted credentials will be signed in.

      await _instance.signInWithCredential(credential);
    } catch (e) {
      print('Error on sign in code: ${e.toString()}');
    }
  }

  _verificationFailed(FirebaseAuthException error) {
    print('error ----------------- on verfivation: ${error.toString()}');
    emit(SubmitNumberFailure(errorMsg: error.toString()));
  }

  _codeSent(String verificationId, int? resendToken) {
    print('code sent ');

    this.verificationId = verificationId;
    emit(SubmitNumberSuccess());
  }

  _codeAutoRetrievalTimeout(String verificationId) {
    print('codeAutoRetrievalTimeout');
  }
  // Future<void> validateAndVerifyPhoneNumber() async {
  //   await _verifyPhoneNumber();
  // }

  // ///
  // Future<void> _verifyPhoneNumber() async {
  //   emit(SubmitNumberLoading());
  //   try {
  //     await _repo.verifyPhoneNumber(phoneNumber: phoneController.text);
  //     emit(SubmitNumberSuccess());
  //   } catch (e) {
  //     print('===>  Submit auth cubit ${e.toString()}');
  //     emit(SubmitNumberFailure(errorMsg: e.toString()));
  //   }
  // }

  // Future<void> verifyOtp(String otpCode) async {
  //   emit(OtpVerifiedLoading());
  //   try {
  //     await _repo.verifyOtp(otpCode);
  //     emit(OtpVerifiedSuccess());
  //   } catch (e) {
  //     print('===>  OTP auth cubit ${e.toString()}');
  //     emit(OtpVerifiedFailure(errorMsg: e.toString()));
  //   }
  // }
}
