import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:just_chat/modules/auth/data/repos/user_data_repo.dart';
import 'package:meta/meta.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../data/models/user_model.dart';

part 'user_data_state.dart';

class UserDataCubit extends Cubit<UserDataState> {
  final UserDataRepo _userDataRepo = getIt<UserDataRepo>();
  UserDataCubit() : super(UserDataInitial());

  Future<void> setUserData(UserModel user) async {
    emit(SetUserDataLoading());
    try {
      //
      await _userDataRepo.createUserAfterPhoneVerification(user);
      emit(SetUserDataSuccess());
      //
    } catch (e) {
      print('=======>>> Set user data error ${e.toString()}');
      emit(SetUserDataFailure(errorMsg: e.toString()));
    }
  }

  Future<void> updateUserData(UserModel user) async {
    emit(UpdateUserDataLoading());
    try {
      //
      await _userDataRepo.updateUserData(user);
      log('=======>>> Update user data =====');

      emit(UpdateUserDataSuccess());
      //
    } catch (e) {
      print('=======>>> Update user data error ${e.toString()}');
      emit(UpdateUserDataFailure(errorMsg: e.toString()));
    }
  }

  Future<void> getUserData() async {
    emit(GetUserDataLoading());
    try {
      await _userDataRepo.getUserData().then(
            (value) => emit(
              GetUserDataSuccess(
                userModel: value,
              ),
            ),
          );
    } catch (e) {
      emit(GetUserDataFailure(errorMsg: e.toString()));
      log('=======>>> Get user data error ${e.toString()}');
    }
  }
}
