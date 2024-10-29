import '../../../modules/messages/data/models/message_model.dart';
import '../../constants/enums.dart';

class FcmMsgModel {
  final String opponentFcmToken;
  final String senderName;
  final NotificationType notificationType;

  /// in Video Call will be the channel Id.
  final String chatId;
  final MessageModel? chatMsg;

  FcmMsgModel({
    required this.opponentFcmToken,
    required this.senderName,
    required this.chatId,
    required this.notificationType,
    this.chatMsg,
  });

  Map<String, dynamic> toFcmJson() => {
        "message": {
          'token': opponentFcmToken,
          "notification": {
            "title": senderName,
            "body": chatMsg?.content,
          },
          "data": {
            "chatId": chatId,
            "type": notificationType.name,
            "chatType": chatMsg?.contentType  ,
          }
        }
      };
}
