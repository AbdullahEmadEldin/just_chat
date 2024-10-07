class MessageModel {
  final String senderId;
  /// either text or media url.
  final String content;
  final String contentType;
  final DateTime createdAt;
  final bool isSeen;
  final bool isReceived;

  MessageModel({
    required this.senderId,
    required this.content,
    required this.contentType,
    required this.createdAt,
    required this.isSeen,
    required this.isReceived,
  });

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'content': content,
      'contentType': contentType,
      'createdAt':
          '${createdAt.hour.toString()}:${createdAt.minute.toString()}',
      'isSeen': isSeen,
      'isReceived': isReceived,
    };
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      senderId: json['senderId'],
      content: json['content'],
      contentType: json['contentType'],
      createdAt: DateTime.parse(json['createdAt']),
      isSeen: json['isSeen'],
      isReceived: json['isReceived'],
    );
  }
}
