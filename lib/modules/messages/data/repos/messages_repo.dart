
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
          .orderBy('sentTime', descending: true)
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
  void sendMessage({
    required MessageModel message,
  }) async {
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
        'isSeen': false,
        'lastMessage': message.content,
        'lastMessageTimestamp': DateTime.now(),
        'lastMessageSenderId': getIt<FirebaseAuth>().currentUser!.uid,
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> sendFirstMsg({
    required String userId,
    required String chatId,
    required MessageModel msg,
  }) async {
    DocumentReference chatDocRef =
        getIt<FirebaseFirestore>().collection('chats').doc(chatId);

    await chatDocRef.set(
      {
        'chatId': chatId,
        'members': [
          getIt<FirebaseAuth>().currentUser!.uid,
          userId,
        ],
        'isSeen': false,
        'lastMessage': msg.content,
        "chatCreatedAt": DateTime.now(),
        'lastMessageTimestamp': DateTime.now(),
        'lastMessageSenderId': getIt<FirebaseAuth>().currentUser!.uid,
      },
    );

    CollectionReference messagesRef = chatDocRef.collection('messages');
    await messagesRef.add(msg.toJson());
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

  @override
  Future<void> markMsgsAsSeen({
    required String chatId,
  }) async {
    final localId = getIt<FirebaseAuth>().currentUser!.uid;

    /// final messagesQuery: This creates a query that will later be executed
    /// to fetch `His` messages that haven't been seen.
    final msgQuery = getIt<FirebaseFirestore>()
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .where('senderId', isNotEqualTo: localId)
        .where(
          'isSeen',
          isEqualTo: false,
        );

    ///Executes the previously built query
    final msgQuerySnapshot = await msgQuery.get();

    /// Creates a WriteBatch object, which allows multiple write operations (like updates or deletes)
    /// to be performed in a single batch. Using a batch ensures that all updates happen together,
    /// which is more efficient and reduces the number of write operations sent to Firestore.
    WriteBatch batch = getIt<FirebaseFirestore>().batch();

    /// For each document in the query snapshot, update the 'isSeen' field
    for (var doc in msgQuerySnapshot.docs) {
      batch.update(doc.reference, {'isSeen': true});
    }

    /// The commit method sends all the updates in the batch to Firestore as a single atomic operation.
    /// This means that all messages are updated at once.
    await batch.commit();

    /// Update the 'isSeen' field in the 'chats' collection
    //? This field wouldn't be used at any part of the application.
    //? but it's use to just trigger the stream listener to update the UI with 0 unread msgs when the chat is opened.
    final chatDocRef =
        getIt<FirebaseFirestore>().collection('chats').doc(chatId);
    final chatDocSnapShot = await chatDocRef.get();
    final chatData = chatDocSnapShot.data() as Map<String, dynamic>;
    if (chatData['lastMessageSenderId'] != localId) {
      chatDocRef.update({
        'isSeen': true,
      });
    }
  }
}
