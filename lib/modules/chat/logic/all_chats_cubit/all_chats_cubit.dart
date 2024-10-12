import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:just_chat/core/di/dependency_injection.dart';
import 'package:just_chat/core/services/firestore_service.dart';
import 'package:meta/meta.dart';

import '../../../auth/data/models/user_model.dart';
import '../../data/models/chat_model.dart';
import '../../data/repos/chat_repo_interface.dart';

part 'all_chats_state.dart';

class AllChatsCubit extends Cubit<AllChatsState> {
  AllChatsCubit() : super(AllChatsInitial());

  UserModel? opponentUser;
  Stream<List<ChatModel>?> getAllChats() {
    print('====== Getting chats Cubit');
    emit(AllChatsLoading());
    try {
      emit(AllChatsLoaded());
      return getIt<ChatRepoInterface>().getAllChats();
    } catch (e) {
      emit(AllChatsFailure(message: e.toString()));

      return const Stream.empty();
    }
  }

  Future<void> getOpponentUserInfoForChatTile(
      {required List<String> chatMembers}) async {
    print('------ Getting opponent user info CUBIT--------');
    String opponentId = '';
    for (int i = 0; i < chatMembers.length; i++) {
      if (chatMembers[i] != getIt<FirebaseAuth>().currentUser!.uid) {
        opponentId = chatMembers[i];
        return;
      }
    }
    opponentUser = await FirebaseGeneralServices.getUserById(opponentId);
    print('------ Getting opponent user info CUBIT LAST--------');
  }
}
