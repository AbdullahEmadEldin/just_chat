import '../../../modules/messages/data/models/message_model.dart';

class FcmMsgModel {
  final String opponentFcmToken;
  final String senderName;
  final String notificationType;

  /// in Video Call will be the channed Id.
  final String chatId;
  final MessageModel? chatMsg;

  FcmMsgModel({
    required this.opponentFcmToken,
    required this.senderName,
    required this.chatId,
    required this.notificationType,
    this.chatMsg,
  });

  Map<String, dynamic> toJson() => {
        'pponentFcmToken': opponentFcmToken,
        'senderName': senderName,
        'chatId': chatId,
        'chatMsg': chatMsg?.toJson(),
      };
}
