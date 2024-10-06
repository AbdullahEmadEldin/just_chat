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
}
