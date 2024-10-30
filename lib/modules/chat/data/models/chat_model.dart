import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../messages/data/models/message_model.dart';

class ChatModel {
  final String chatId;
  final List<String> members;
  final String? lastMessage;
  final Timestamp? lastMessageTimestamp;
  final String? lastMessageSenderId;
  final String? groupName;
  final String? groupImageUrl;
  final Timestamp? chatCreatedAt;
  final List<MessageModel>? messages;

  ChatModel({
    required this.chatId,
    required this.members,
    this.chatCreatedAt,
    this.messages,
    this.lastMessage,
    this.lastMessageTimestamp,
    this.lastMessageSenderId,
    this.groupName,
    this.groupImageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'chatId': chatId,
      'members': members,
      'messages': messages?.map((e) => e.toJson()).toList(),
      'lastMessage': lastMessage,
      'lastMessageTimestamp': lastMessageTimestamp,
      'lastMessageSenderId': lastMessageSenderId,
      'groupName': groupName,
      'groupImageUrl': groupImageUrl,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      chatCreatedAt: map['chatCreatedAt'],
      chatId: map['chatId'],
      members: List<String>.from(map['members']),
      messages: map['messages'] != null
          ? List<MessageModel>.from(
              map['messages'].map((x) => MessageModel.fromJson(x)),
            )
          : null,
      lastMessage: map['lastMessage'],
      lastMessageTimestamp: map['lastMessageTimestamp'],
      lastMessageSenderId: map['lastMessageSenderId'],
      groupName: map['groupName'],
      groupImageUrl: map['groupImageUrl'],
    );
  }
}
