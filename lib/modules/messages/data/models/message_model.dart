import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String msgId;
  final String? chatId;
  final String senderId;
  final String? replyMsgId;

  /// either text or media url.
  final String content;
  final String contentType;
  final Timestamp sentTime;
  final bool isSeen;
  final bool isReceived;

  MessageModel({
    this.chatId,
    required this.msgId,
    required this.senderId,
    this.replyMsgId,
    required this.content,
    required this.contentType,
    required this.sentTime,
    required this.isSeen,
    required this.isReceived,
  });

  Map<String, dynamic> toJson() {
    return {
      'chatId': chatId,
      'msgId': msgId,
      'replyMsgId': replyMsgId,
      'senderId': senderId,
      'content': content,
      'contentType': contentType,
      'sentTime': sentTime.toDate(),
      'isSeen': isSeen,
      'isReceived': isReceived,
    };
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      chatId: json['chatId'],
      msgId: json['msgId'],
      senderId: json['senderId'],
      replyMsgId: json['replyMsgId'] ,
      content: json['content'],
      contentType: json['contentType'],
      sentTime: json['sentTime'],
      isSeen: json['isSeen'],
      isReceived: json['isReceived'],
    );
  }

  MessageModel copyWith({
    String? chatId,
    String? msgId,
    String? senderId,
    String? replyMsgId,
    String? content,
    String? contentType,
    Timestamp? sentTime,
    bool? isSeen,
    bool? isReceived,
  }) {
    return MessageModel(
      chatId: chatId ?? this.chatId,
      msgId: msgId ?? this.msgId,
      senderId: senderId ?? this.senderId,
      content: content ?? this.content,
      contentType: contentType ?? this.contentType,
      sentTime: sentTime ?? this.sentTime,
      isSeen: isSeen ?? this.isSeen,
      isReceived: isReceived ?? this.isReceived,
      replyMsgId: replyMsgId ?? this.replyMsgId,
    );
  }
}
