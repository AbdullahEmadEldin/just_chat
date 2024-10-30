import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_chat/core/services/firestore_service.dart';
import 'package:just_chat/modules/auth/data/models/user_model.dart';
import 'package:just_chat/modules/messages/data/repos/msg_repo_interface.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/services/firebase_notifiaction/firebase_cloud_msgs.dart';
import '../../../../core/services/firebase_notifiaction/firebase_msg_model.dart';
import '../../data/models/message_model.dart';

part 'messaging_state.dart';

class MessagingCubit extends Cubit<MessagingState> {
  String chatId;
  String remoteUserId;
  MessagingCubit({
    required this.chatId,
    required this.remoteUserId,
  }) : super(MessagingInitial());

  UserModel? opponentUser;
  MessageModel? replyToMessage;
  bool firstMsgInChat = false;
  Future<void> fetchChatRoomArgs() async {
    emit(FetchPageArgsLoading());
    opponentUser = await FirebaseGeneralServices.getUserById(remoteUserId);
    emit(FetchPageArgsSuccess());
    log('fetch ======Chat Room Args ==${opponentUser?.name}==');
  }

  //***************************** Get Chat Messages *************************  */
  Stream<List<MessageModel>?> getChatMessages(String chatId) {
    try {
      return getIt<MsgsRepoInterface>().getChatMessages(chatId);
    } on Exception catch (e) {
      print('Erorr gerring messges cubiiiiiiiiiiiiiit :: $e');
      return const Stream.empty();
    }
  }

  //***************************** Send Message *************************  */
  Future<void> sendMessage({
    required MessageModel message,
  }) async {
    try {
      /// Get My user name to pass it to notification
      final userName = await FirebaseGeneralServices.getUserById(
        getIt<FirebaseAuth>().currentUser!.uid,
      ).then((value) => value.name);

      ///
      if (replyToMessage != null) {
        getIt<MsgsRepoInterface>().sendMessage(
          message: message.copyWith(
            replyMsgId: replyToMessage!.msgId,
          ),
        );
        cancelReplyToMsgBox();
      } else {
        getIt<MsgsRepoInterface>().sendMessage(
          message: message,
        );
      }
      textingController.clear();

      ///
      /// Send Notification...
      ///

      await FcmService.sendNotification(
        FcmMsgModel(
          remoteUserId: remoteUserId,
          opponentFcmToken: opponentUser!.fcmToken!,
          senderName: userName,
          chatId: chatId,
          chatMsg: message,
          notificationType: NotificationType.chat,
        ),
      );
    } on Exception catch (e) {
      debugPrint('Error ===== $e');
    }
  }

  Future<void> sendFirstMsg({
    required MessageModel msg,
  }) async {
    try {
      await getIt<MsgsRepoInterface>().sendFirstMsg(
        userId: remoteUserId,
        chatId: chatId,
        msg: msg,
      );

      /// Get My user name to pass it to notification
      final userName = await FirebaseGeneralServices.getUserById(
        getIt<FirebaseAuth>().currentUser!.uid,
      ).then((value) => value.name);

      ///
      /// Send Notification...
      ///

      await FcmService.sendNotification(
        FcmMsgModel(
          remoteUserId: remoteUserId,
          opponentFcmToken: opponentUser!.fcmToken!,
          senderName: userName,
          chatId: chatId,
          chatMsg: msg,
          notificationType: NotificationType.chat,
        ),
      );
    } on Exception catch (e) {
      log('Error ===== $e');
    }
  }

  ///
  ///
  ///

  void markMsgAsSeen() async {
    try {
      log('=====>> mark msg as seen cubit <<====');
      await getIt<MsgsRepoInterface>().markMsgsAsSeen(chatId: chatId);
    } catch (e) {
      print('Error mark msg as seen cubit :: $e');
    }
  }

  //***************************** Delete Message *************************  */
  void deleteMsg({required MessageModel message}) {
    try {
      getIt<MsgsRepoInterface>()
          .deleteMsg(chatId: message.chatId!, message: message);
    } on Exception catch (e) {
      print('Erorr deleting messges cubiiiiiiiiiiiiiit :: $e');
    }
  }

  //! ============================================================
  //! ================= Handling UI Logic ========================
  //! ============================================================
  void replyToMsgBoxTrigger({
    required MessageModel replyToMessage,
  }) {
    this.replyToMessage = replyToMessage;
    emit(ReplyToMessageState(replyToMessage: replyToMessage));
  }

  void cancelReplyToMsgBox() {
    replyToMessage = null;
    print('===== cancel replying =====');
    emit(CancelReplyToMessageState());
  }

  /// used to scroll down to the last msg when open the chat or send new msg.
  final ScrollController scrollController = ScrollController();

  /// used to handle the text msg input and icons of send button
  final TextEditingController textingController = TextEditingController();

  /// used to get the message position and control it.
  final GlobalKey messageKey = GlobalKey();
  //
  void switchSendButtonIcon() {
    if (textingController.text.isEmpty) {
      emit(SwitchSendButtonIcon(newIcon: CupertinoIcons.mic));
    } else {
      emit(SwitchSendButtonIcon(newIcon: Icons.send));
    }
  }

  void setSquareBorderRadius() {
    if (textingController.text.length == 20) {
      emit(SetBorderRadiusToSquare());
    }
    if (textingController.text.length < 20) {
      emit(SetBorderRadiusToCircle());
    }
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    opponentUser = null;
    return super.close();
  }
}
