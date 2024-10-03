import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setUpGetIt() {
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  getIt.registerLazySingleton<PhoneAuthInfo>(() => PhoneAuthInfo());
}

class PhoneAuthInfo {
  String? verificationId;
  String? phoneNumber;

  /// Cerate this class wit ha single String parameter
  /// to make it easy to identify the verification id & phone number through code
  /// and access it globally
  PhoneAuthInfo({this.verificationId, this.phoneNumber});
}
