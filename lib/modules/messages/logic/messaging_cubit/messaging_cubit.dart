import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_chat/modules/messages/data/repos/msg_repo_interface.dart';
import 'package:meta/meta.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../data/models/message_model.dart';

part 'messaging_state.dart';

class MessagingCubit extends Cubit<MessagingState> {
  MessagingCubit() : super(MessagingInitial());

  Stream<List<MessageModel>?> getChatMessages(String chatId) {
    try {
      return getIt<MsgsRepoInterface>().getChatMessages(chatId);
    } on Exception catch (e) {
      print('Erorr gerring messges cubiiiiiiiiiiiiiit :: $e');
      return const Stream.empty();
    }
  }

  void sendMessage({required String chatId, required MessageModel message}) {
    try {
      print('Sending...CUBIT');
      getIt<MsgsRepoInterface>().sendMessage(chatId: chatId, message: message);
      textingController.clear();
    } on Exception catch (e) {
      print('Erorr sending messges cubiiiiiiiiiiiiiit :: $e');
    }
  }

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
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOutCirc,
          );
        }
      });
    });
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    return super.close();
  }
}
