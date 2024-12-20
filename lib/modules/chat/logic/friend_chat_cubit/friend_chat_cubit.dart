import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:just_chat/core/di/dependency_injection.dart';
import 'package:just_chat/core/services/firestore_service.dart';
import 'package:meta/meta.dart';

import '../../../auth/data/models/user_model.dart';
import '../../data/models/chat_model.dart';
import '../../data/repos/chat_repo_interface.dart';

part 'friend_chat_state.dart';

class FriendsChatCubit extends Cubit<FriendsChatState> {
  FriendsChatCubit() : super(AllChatsInitial());

  void getAllChats() {
    emit(GetChatsLoading());
    try {
      getIt<ChatRepoInterface>().getAllChats().listen((chatsList) async {
        var opponentUsers = await _getOpponentUsersList(chatsList!);
        var unreadMsgsCount = await _getCountOfUnreadMessages(chatsList);
        emit(
          GetChatsSuccess(
            chats: chatsList,
            opponentUsers: opponentUsers,
            unreadMsgsCount: unreadMsgsCount,
          ),
        );
      });
    } catch (e) {
      emit(GetChatsFailure(error: 'Error on getting chats: ${e.toString()}'));
    }
  }

//! private helpers///
  _getOpponentUsersList(List<ChatModel> chats) async {
    List<UserModel> users = [];
    for (var chat in chats) {
      // get opponent user for each chat.
      var user =
          await _getOpponentUserInfoForChatTile(chatMembers: chat.members);
      users.add(user);
    }

    return users;
  }

  Future<UserModel> _getOpponentUserInfoForChatTile({
    required List<String> chatMembers,
  }) async {
    try {
      String opponentId = '';
      for (int i = 0; i < chatMembers.length; i++) {
        if (chatMembers[i] != getIt<FirebaseAuth>().currentUser!.uid) {
          opponentId = chatMembers[i];
          break;
        }
      }
      return await FirebaseGeneralServices.getUserById(opponentId);
    } catch (e) {
      rethrow;
    }
  }

  _getCountOfUnreadMessages(List<ChatModel> chats) async {
    try {
      List<int> unreadMsgsOfChats = [];
      for (var chat in chats) {
        int count = await getIt<ChatRepoInterface>()
            .getUnreadChatsCount(chatId: chat.chatId);
        unreadMsgsOfChats.add(count);
      }
      return unreadMsgsOfChats;
    } catch (e) {
      log('This is Error on getting count of unread messages: ${e.toString()}');
      rethrow;
    }
  }

  @override
  Future<void> close() {
    log('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Close all Chats Cubit');
    return super.close();
  }
}
