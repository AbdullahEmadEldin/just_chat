import 'package:bloc/bloc.dart';
import 'package:just_chat/modules/add_friends/data/add_friends_repo.dart';
import 'package:meta/meta.dart';

import '../../../auth/data/models/user_model.dart';

part 'add_friends_state.dart';

class AddFriendsCubit extends Cubit<AddFriendsState> {
  final AddFriendsRepo _repo = AddFriendsRepo();
  AddFriendsCubit() : super(AddFriendsInitial());

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

  // Future<void> addFriendToChat({required UserModel user}) async {
  //   try {
  //     await _repo.addFriend(userId: user.uid);
  //   } catch (e) {
  //     print('=============== ERROR in starting chat with user ${e.toString()}');
  //   }
  // }
}
