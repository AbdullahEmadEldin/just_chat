import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/core/helpers/extensions.dart';
import 'package:just_chat/modules/auth/logic/cubit/auth_cubit.dart';
import 'package:just_chat/modules/auth/view/page/check_otp_page.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/constants/loties_assets.dart';

class SubmitPhoneListener extends StatelessWidget {
  const SubmitPhoneListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PhoneAuthCubit, PhoneAuthState>(
      listener: (context, state) {
        if (state is SubmitNumberLoading) {
          print('**************************');
          showDialog(
            context: context,
            builder: (context) => Center(
              child: Lottie.asset(LottiesAssets.loadingChat, width: 250.w),
            ),
          );
        } else if (state is SubmitNumberSuccess) {
          print(
              '----------------------------------===============================');
          Navigator.pop(context);
          context.pushNamed(OtpVerificationPage.routeName);
        } else if (state is SubmitNumberFailure) {
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (context) => Center(
              child: Text('Error: ${state.errorMsg}'),
            ),
          );
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
