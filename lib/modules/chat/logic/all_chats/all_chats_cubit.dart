import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/constants/enums.dart';

part 'all_chats_state.dart';

class AllChatsCubit extends Cubit<AllChatsState> {
  AllChatsCubit() : super(AllChatsInitial());

    //!! UI Control ======
  void switchBetweenChatTypes(ChatType chatType){
    emit(SwitchBetweenChatTypes(chatType: chatType));
  }
}
