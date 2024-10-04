import 'package:bloc/bloc.dart';
import 'package:just_chat/modules/auth/data/repos/user_data_repo.dart';
import 'package:meta/meta.dart';

import '../../data/models/user_model.dart';

part 'user_data_state.dart';

class UserDataCubit extends Cubit<UserDataState> {
  final UserDataRepo userDataRepo;
  UserDataCubit(this.userDataRepo) : super(UserDataInitial());

  Future<void> setUserData(UserModel user) async {
    emit(SetUserDataLoading());
    try {
      //
      await userDataRepo.createUserAfterPhoneVerification(user);
      emit(SetUserDataSuccess());
      //
    } catch (e) {
      print('=======>>> Set user data error ${e.toString()}');
      emit(SetUserDataFailure(errorMsg: e.toString()));
    }
  }
}
