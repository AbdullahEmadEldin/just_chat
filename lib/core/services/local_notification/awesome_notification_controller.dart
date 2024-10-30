import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:just_chat/modules/messages/view/pages/messaging_page.dart';
import 'package:just_chat/modules/rtc_agora/video_call_page.dart';

import '../../../app_entry.dart';

class AwesomeNotificationController {
  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
    ReceivedNotification receivedNotification,
  ) async {
    // Your code goes here
    log('onNotificationCreatedMethod ===============');
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
    ReceivedNotification receivedNotification,
  ) async {
    // Your code goes here
    log('onNotificationDisplayedMethod ==========1111===${receivedNotification.category}==');
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    // Your code goes here
    log('onDismissActionReceivedMethod =======222 ====${receivedAction.payload}====');
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    log('onActionReceivedMethod =======333===${receivedAction.groupKey}=====');
    _handleNavigationAction(receivedAction);
  }

  static _handleNavigationAction(
    ReceivedAction receivedAction,
  ) {
    if (receivedAction.buttonKeyPressed == 'ANSWER' ||
        receivedAction.groupKey == 'call') {
      navigatorKey.currentState?.pushNamed(
        VideoCallPage.routeName,
        // This arg represents channel id but it will not used as we use a static chanel id from Agora Console.
        arguments: 'receivedAction.payload',
      );
    } else if (receivedAction.groupKey == 'chat') {
      log('onActionReceivedMethod =======Should Navigate =to chat ROOM=====');

      navigatorKey.currentState?.pushNamed(
        MessagingPage.routeName,
        arguments: MessagingPageArgs(
            chatId: receivedAction.payload?['chatId'] as String,
            remoteUserId: receivedAction.payload?['remoteUserId'] as String),
      );
    }
  }
}
