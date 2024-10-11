import 'package:bloc/bloc.dart';
import 'package:just_chat/core/di/dependency_injection.dart';
import 'package:just_chat/modules/chat/data/repos/chat_repo.dart';
import 'package:meta/meta.dart';

part 'all_chats_state.dart';

class AllChatsCubit extends Cubit<AllChatsState> {
  AllChatsCubit() : super(AllChatsInitial());

  void getAllChats() {
    try {
      getIt<ChatRepoInterface>().getAllChats();
    } catch (e) {}
  }
}
