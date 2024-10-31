
import 'package:bloc/bloc.dart';
import 'package:just_chat/modules/add_friends/data/search_for_friends_repo.dart';
import 'package:meta/meta.dart';

import '../../../auth/data/models/user_model.dart';

part 'search_for_friends_state.dart';

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
