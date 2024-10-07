import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/core/constants/app_strings.dart';
import 'package:just_chat/core/helpers/extensions.dart';
import 'package:just_chat/modules/auth/logic/user_data_cubit/user_data_cubit.dart';
import 'package:just_chat/modules/chat/view/pages/all_chats_page.dart';
import 'package:just_chat/modules/nav_bar/custom_nav_bar.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/constants/loties_assets.dart';

class FillDataBlocListener extends StatelessWidget {
  const FillDataBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserDataCubit, UserDataState>(
      listener: (context, state) {
        if (state is SetUserDataLoading) {
          print('**************************');
          showDialog(
            context: context,
            builder: (context) => Center(
              child: Lottie.asset(LottiesAssets.loadingChat, width: 250.w),
            ),
          );
        } else if (state is SetUserDataSuccess) {
          Navigator.pop(context);
          context.pushReplacementNamed(CustomNavBar.routeName);
        } else if (state is SetUserDataFailure) {
          Navigator.pop(context);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              animType: AnimType.rightSlide,
              title: AppStrings.errorOccured.tr(),
              desc: state.errorMsg,
              btnOkOnPress: () {},
            ).show();
          });
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
