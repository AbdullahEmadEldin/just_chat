import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:just_chat/core/di/dependency_injection.dart';
import 'package:just_chat/modules/auth/data/models/user_model.dart';
import 'package:uuid/uuid.dart';

class AddFriendsRepo {
  Future<List<UserModel>> searchUsersByPhoneNumber(String phoneNumber) async {
    final querySnapshots = await getIt<FirebaseFirestore>()
        .collection('users')
        .where('phoneNumber', isEqualTo: phoneNumber)
        .get();
    if (querySnapshots.docs.isEmpty) {
      // no matching  data found
      return [];
    } else {
      // parsing the data results to UserModel
      final users = querySnapshots.docs
          .map((doc) => UserModel.fromMap(doc.data()))
          .toList();

      return users;
    }
  }

  /// This function actually will start a new chat with the user
  Future<void> addFriend({required String userId}) async {
    final docId = getIt<Uuid>().v1();
    DocumentReference docRef =
        getIt<FirebaseFirestore>().collection('chats').doc(docId);
   
    await docRef.set(
      {
        'chatId': docId,
        'members': [
          getIt<FirebaseAuth>().currentUser!.uid,
          userId,
        ],
        'messages': [],
      },
    );
  }
}
