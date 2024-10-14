import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:just_chat/modules/messages/data/models/message_model.dart';
import 'package:just_chat/modules/messages/data/repos/msg_repo_interface.dart';

import '../../../../core/di/dependency_injection.dart';

class FirebaseMsgRepo implements MsgsRepoInterface{
  @override
  Stream<List<MessageModel>?> getChatMessages(String chatId) {
    try {
      return getIt<FirebaseFirestore>()
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .orderBy('sentTime', descending: false)
          .snapshots()
          .map((snapShot) {
        return snapShot.docs
            .map((message) => MessageModel.fromJson(message.data()))
            .toList();
      });
    } catch (e) {
      rethrow;
    }
  }

  void sendMessage(
      {required String chatId, required MessageModel message}) async {
    try {
      final msgId = await getIt<FirebaseFirestore>()
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .add(message.toJson());

      /// update last message and timestamp
      getIt<FirebaseFirestore>().collection('chats').doc(chatId).update({
        'lastMessage': message.content,
        'lastMessageTimestamp': DateTime.now(),
        'lastMessageSenderId': getIt<FirebaseAuth>().currentUser!.uid,
      });
    } catch (e) {
      rethrow;
    }
  }
}
