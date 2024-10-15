import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:just_chat/modules/messages/data/models/message_model.dart';
import 'package:just_chat/modules/messages/data/repos/msg_repo_interface.dart';

import '../../../../core/di/dependency_injection.dart';

class FirebaseMsgRepo implements MsgsRepoInterface {
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

  @override
  void sendMessage({required MessageModel message}) async {
    try {
      await getIt<FirebaseFirestore>()
          .collection('chats')
          .doc(message.chatId)
          .collection('messages')
          .doc(message.msgId)
          .set(message.copyWith(chatId: message.chatId).toJson());

      /// update last message and timestamp in chat document
      getIt<FirebaseFirestore>()
          .collection('chats')
          .doc(message.chatId)
          .update({
        'lastMessage': message.content,
        'lastMessageTimestamp': DateTime.now(),
        'lastMessageSenderId': getIt<FirebaseAuth>().currentUser!.uid,
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  void deleteMsg({
    required String chatId,
    required MessageModel message,
  }) {
    try {
      getIt<FirebaseFirestore>()
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .doc(message.msgId)
          .delete();
    } catch (e) {
      rethrow;
    }
  }
}
