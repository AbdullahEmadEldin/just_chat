// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/di/dependency_injection.dart';

part 'auth_state.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  PhoneAuthCubit() : super(PhoneAuthInitial());

  ///

  final formKey = GlobalKey<FormState>();
  String phoneNumber = '';
  String verificationId = '';

  ///! Identify Phone number on firebase and send SMS code
  ///
  Future<void> validateAndVerify() async {
    if (formKey.currentState!.validate()) {
      await verifyPhoneNumber();
    }
  }

  Future<void> verifyPhoneNumber() async {
    emit(SubmitNumberLoading());
    try {
      await getIt<FirebaseAuth>().verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: _verificationCompleted,
        verificationFailed: _verificationFailed,
        codeSent: _codeSent,
        codeAutoRetrievalTimeout: _codeAutoRetrievalTimeout,
      );
    } on PlatformException catch (e) {
      emit(SubmitNumberFailure(errorMsg: e.message.toString()));
      print(e.message);
    }
  }

  ///! verify OTP code
  ///
  Future<void> verifyOtp(String otpCode) async {
    emit(OtpVerifiedLoading());
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId, // comes from verify phone number method.
      smsCode: otpCode,
    );
    try {
      final UserCredential userCredential =
          await getIt<FirebaseAuth>().signInWithCredential(credential);
      print('--------------->>>>>>>> ${userCredential.additionalUserInfo!.isNewUser}');
      userCredential.additionalUserInfo!.isNewUser;
      emit(OtpVerifiedSuccess());
    } on PlatformException catch (e) {
      emit(OtpVerifiedFailure(errorMsg: e.message.toString()));
      print(e.message);
    }
  }

  //! log out
  ///
  Future<void> logOut() async {
    await getIt<FirebaseAuth>().signOut();
  }

  //! get user info.
  ///
  User getUserInfo() {
    return getIt<FirebaseAuth>().currentUser!;
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

      await getIt<FirebaseAuth>().signInWithCredential(credential);
    } catch (e) {
      print('Error on sign in code: ${e.toString()}');
    }
  }

  _verificationFailed(FirebaseAuthException error) {
    print('error ----------------- on verfivation: ${error.code.toString()}');
    emit(SubmitNumberFailure(errorMsg: error.code.toString()));
  }

  _codeSent(String verificationId, int? resendToken) {
    print('code sent ');

    this.verificationId = verificationId;
    emit(SubmitNumberSuccess());
  }

  _codeAutoRetrievalTimeout(String verificationId) {
    print('codeAutoRetrievalTimeout');
  }
}
