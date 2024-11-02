import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:get_it/get_it.dart';
import 'package:just_chat/modules/auth/data/repos/user_data_repo.dart';
import 'package:just_chat/modules/chat/data/repos/firebase_chat_repo.dart';
import 'package:just_chat/modules/messages/data/repos/messages_repo.dart';
import 'package:just_chat/modules/messages/data/repos/msg_repo_interface.dart';
import 'package:uuid/uuid.dart';

import '../../modules/chat/data/repos/chat_repo_interface.dart';

final getIt = GetIt.instance;

void setUpGetIt() {
  getIt.registerLazySingleton<Uuid>(() => const Uuid());
  // This global instance for access auth info over the app
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  // This global instance for access storage database over the app
  getIt.registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);

  // This global instance of firebase chat repo
  getIt.registerLazySingleton<ChatRepoInterface>(() => FirebaseChatRepo());
  getIt.registerLazySingleton<MsgsRepoInterface>(() => FirebaseMsgRepo());

  // This global instance for access firestore storage over the app.
  getIt.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);

  // This global instance for access firebase messaging over the app for Notification management.
  getIt.registerLazySingleton<FirebaseMessaging>(
      () => FirebaseMessaging.instance);

  // This global instance for access auth info over the app
  getIt.registerLazySingleton<PhoneAuthInfo>(() => PhoneAuthInfo());

  getIt.registerLazySingleton<UserDataRepo>(() => UserDataRepo());
}

class PhoneAuthInfo {
  String? verificationId;
  String? phoneNumber;

  /// Cerate this class wit ha single String parameter
  /// to make it easy to identify the verification id & phone number through code
  /// and access it globally
  PhoneAuthInfo({this.verificationId, this.phoneNumber});
}
