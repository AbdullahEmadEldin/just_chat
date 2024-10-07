import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'messaging_state.dart';

class MessagingCubit extends Cubit<MessagingState> {
  MessagingCubit() : super(MessagingInitial());

  final TextEditingController textingController = TextEditingController();

  //! ================= Handling UI Logic ==================
  void switchSendButtonIcon() {
    if (textingController.text.isEmpty) {
      emit(SwitchSendButtonIcon(newIcon: CupertinoIcons.mic));
    } else {
      emit(SwitchSendButtonIcon(newIcon: Icons.send));
    }
  }
}
