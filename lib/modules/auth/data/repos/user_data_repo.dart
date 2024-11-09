import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:just_chat/modules/auth/data/models/user_model.dart';

import '../../../../core/di/dependency_injection.dart';

class UserDataRepo {
  Future<void> createUserAfterPhoneVerification(UserModel user) async {
    final String createdUserId = getIt<FirebaseAuth>().currentUser!.uid;
    await getIt<FirebaseFirestore>().collection('users').doc(createdUserId).set(
          user.toMap(),
        );
  }

  Future<void> updateUserData(UserModel user) async {
    final String createdUserId = getIt<FirebaseAuth>().currentUser!.uid;
    await getIt<FirebaseFirestore>()
        .collection('users')
        .doc(createdUserId)
        .update(
          user.toMap(),
        );
  }

  Future<UserModel> getUserData() async {
    final String userId = getIt<FirebaseAuth>().currentUser!.uid;
    final userRef = getIt<FirebaseFirestore>().collection('users').doc(userId);
    final snapshot = await userRef.get();

    return UserModel.fromMap(snapshot.data()!);
  }

  /// Update user status ONLINE or OFFLINE.
  static Future<void> updateUserStatus(bool isOnline) async {
    final String userId = getIt<FirebaseAuth>().currentUser!.uid;
    log('=====> User is ;;;;;;; $isOnline');
    // Online status
    final userDoc =
        await getIt<FirebaseFirestore>().collection('users').doc(userId).get();
    if (userDoc.exists) {
      await getIt<FirebaseFirestore>().collection('users').doc(userId).update({
        'isOnline': isOnline,
        'lastSeen': Timestamp.now(),
      });
    }
  }
}
