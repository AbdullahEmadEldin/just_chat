import '../../../modules/messages/data/models/message_model.dart';
import '../../constants/enums.dart';

class FcmMsgModel {
  final String opponentFcmToken;
  final String remoteUserId;
  final String senderName;
  final NotificationType notificationType;

  /// in Video Call will be the channel Id.
  final String chatId;
  final MessageModel? chatMsg;

  FcmMsgModel({
    required this.opponentFcmToken,
    required this.remoteUserId,
    required this.senderName,
    required this.chatId,
    required this.notificationType,
    this.chatMsg,
  });

  Map<String, dynamic> toFcmJson() {
    /// if you want to disable push notification from FCM
    /// Don't include "notification": {}
    // final map = {
    //   "message": {
    //     'token': opponentFcmToken,
    //     "notification": {
    //       "title": senderName,
    //       "body": chatMsg?.content,
    //     },
    //     "data": {
    //       "title": senderName,
    //       "body": chatMsg?.content,
    //       "chatId": chatId,
    //       "type": notificationType.name,
    //       "chatType": chatMsg?.contentType,
    //       "remoteUserId": remoteUserId,
    //     }
    //   }
    // };
    final map = {
      "message": {
        'token': opponentFcmToken,
        "data": {
          "title": senderName,
          "body": chatMsg?.content,
          "chatId": chatId,
          "type": notificationType.name,
          "chatType": chatMsg?.contentType,
          "remoteUserId": remoteUserId,
        }
      }
    };
    return map;
  }
}
