import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:get_it/get_it.dart';
import 'package:just_chat/modules/chat/data/repos/chat_repo.dart';
import 'package:just_chat/modules/chat/data/repos/firebase_chat_repo.dart';

final getIt = GetIt.instance;

void setUpGetIt() {
  // This global instance for access auth info over the app
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  // This global instance for access storage database over the app
  getIt.registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);

  // This global instance of firebase chat repo
  getIt.registerLazySingleton<ChatRepoInterface>(() => FirebaseChatRepo());

  // This global instance for access firestore storage over the app.
  getIt.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);

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
