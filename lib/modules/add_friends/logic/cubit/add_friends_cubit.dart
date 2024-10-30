
import 'package:bloc/bloc.dart';
import 'package:just_chat/modules/add_friends/data/add_friends_repo.dart';
import 'package:meta/meta.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../chat/data/repos/chat_repo_interface.dart';

part 'add_friends_state.dart';

class SearchForFriendsCubit extends Cubit<AddFriendsState> {
  final AddFriendsRepo _repo = AddFriendsRepo();
  SearchForFriendsCubit() : super(AddFriendsInitial());

  void searchForFriendByPhoneNumber({required String phoneNumber}) async {
    emit(SearchForFriendsLoading());
    try {
      final usersResult = await _repo.searchUsersByPhoneNumber(phoneNumber);
      emit(SearchForFriendsSuccess(usersResult));
      //
    } catch (e) {
      emit(SearchForFriendsFailure(errorMsg: e.toString()));
    }
  }

   

}
