import 'message_model.dart';

class ChatModel {
  final String chatId;
  final List<String> ids;
  final List<MessageModel> messages;

  ChatModel({
    required this.chatId,
    required this.ids,
    required this.messages,
  });

  

  factory ChatModel.fromJson(Map<String, dynamic> json) { 
    return ChatModel(
      chatId: json['chatId'],
      ids: List<String>.from(json['ids']),
      messages: List<MessageModel>.from(json['messages'].map((x) => MessageModel.fromJson(x))),
    );
  } 

  Map<String, dynamic> toJson() {
    return {
      'chatId': chatId,
      'ids': ids,
      'messages': List<dynamic>.from(messages.map((x) => x.toJson())),
    };
  }
}
