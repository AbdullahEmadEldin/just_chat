import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:just_chat/core/di/dependency_injection.dart';
import 'package:just_chat/modules/chat/data/models/chat_model.dart';

import 'chat_repo_interface.dart';

class FirebaseChatRepo implements ChatRepoInterface {
  @override
  Stream<List<ChatModel>?> getAllChats() {
    try {
      return getIt<FirebaseFirestore>()
          .collection('chats')
          // query to get all chats that the current user is part of.
          .where(
            'members',
            arrayContains: getIt<FirebaseAuth>().currentUser!.uid,
          )
          .orderBy('lastMessageTimestamp', descending: true)
          // snapshot hold the chat data and other metadata comes from firebase.
          .snapshots()
          // Transforms each element of this stream into a new stream event.
          // after converting each element of this stream to a new value
          .map((snapShot) {
        // [snapShot.docs] hold multiple chats as Maps.
        return snapShot.docs.map((chat) {
          // mapping each chat map into ChatModel.
          final chatInfo = chat.data();
          final singleChat = ChatModel.fromMap(chatInfo);

          return singleChat;
        }).toList();
      });
    } catch (e) {
      rethrow;
    }
  }

  /// This function actually will start a new chat with the user

  @override
  Future<int> getUnreadChatsCount({required String chatId}) async {
    log('Update unread Msg count called ---');
    final msgQuery = getIt<FirebaseFirestore>()
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .where('senderId', isNotEqualTo: getIt<FirebaseAuth>().currentUser!.uid)
        .where('isSeen', isEqualTo: false);

    final msgQuerySnapshot = await msgQuery.get();
    int count = msgQuerySnapshot.docs.length;
    return count;
  }
}
