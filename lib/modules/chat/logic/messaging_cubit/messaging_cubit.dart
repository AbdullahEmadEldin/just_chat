import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../data/models/message_model.dart';
import '../../data/repos/chat_repo_interface.dart';

part 'messaging_state.dart';

class MessagingCubit extends Cubit<MessagingState> {
  MessagingCubit() : super(MessagingInitial());

  Stream<List<MessageModel>?> getChatMessages(String chatId) {
    try {
      return getIt<ChatRepoInterface>().getChatMessages(chatId);
    } on Exception catch (e) {
      print('Erorr gerring messges cubiiiiiiiiiiiiiit :: $e');
      return const Stream.empty();
    }
  }

  //! ================= Handling UI Logic ==================

  final TextEditingController textingController = TextEditingController();

  void switchSendButtonIcon() {
    if (textingController.text.isEmpty) {
      emit(SwitchSendButtonIcon(newIcon: CupertinoIcons.mic));
    } else {
      emit(SwitchSendButtonIcon(newIcon: Icons.send));
    }
  }
}
