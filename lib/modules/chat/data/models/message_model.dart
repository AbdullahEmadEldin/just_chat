import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String senderId;

  /// either text or media url.
  final String content;
  final String contentType;
  final Timestamp sentTime;
  final bool isSeen;
  final bool isReceived;

  MessageModel({
    required this.senderId,
    required this.content,
    required this.contentType,
    required this.sentTime,
    required this.isSeen,
    required this.isReceived,
  });

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'content': content,
      'contentType': contentType,
      'sentTime': sentTime.toDate().toString(),
      'isSeen': isSeen,
      'isReceived': isReceived,
    };
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      senderId: json['senderId'],
      content: json['content'],
      contentType: json['contentType'],
      sentTime: json['sentTime'],
      isSeen: json['isSeen'],
      isReceived: json['isReceived'],
    );
  }
}
