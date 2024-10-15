import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_chat/modules/auth/data/models/user_model.dart';
import 'package:just_chat/modules/messages/data/repos/msg_repo_interface.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../data/models/message_model.dart';

part 'messaging_state.dart';

class MessagingCubit extends Cubit<MessagingState> {
  MessagingCubit() : super(MessagingInitial());

  UserModel? opponentUser;
  MessageModel? replyToMessage;

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
  void sendMessage({
    required MessageModel message,
  }) {
    try {
      if (replyToMessage != null) {
        getIt<MsgsRepoInterface>().sendMessage(
            message: message.copyWith(replyMsgId: replyToMessage!.msgId));
        cancelReplyToMsgBox();
      } else {
        getIt<MsgsRepoInterface>().sendMessage(message: message);
      }
      textingController.clear();
    } on Exception catch (e) {
      debugPrint('Error ===== $e');
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

  void scrollToLastMessage() {
    // calling scroll down within addPostFrameCallback to ensure that it is called after build the new messages in the list.
    // and the Future.delay to ensure that the new widget frame is build and ready to view.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 200), () {
        if (scrollController.hasClients) {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeInOutCirc,
          );
        }
      });
    });
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    opponentUser = null;
    return super.close();
  }
}
