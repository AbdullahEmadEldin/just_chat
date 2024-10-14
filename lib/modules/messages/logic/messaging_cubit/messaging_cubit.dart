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

  //! ================= Handling UI Logic ==================
  final ScrollController scrollController = ScrollController();
  final TextEditingController textingController = TextEditingController();

  void switchSendButtonIcon() {
    if (textingController.text.isEmpty) {
      emit(SwitchSendButtonIcon(newIcon: CupertinoIcons.mic));
    } else {
      emit(SwitchSendButtonIcon(newIcon: Icons.send));
    }
  }

  void scrollToLastMessage() {
    if (scrollController.hasClients) {
      print('222222222222');
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOutCirc,
      );
    }
  }
}
