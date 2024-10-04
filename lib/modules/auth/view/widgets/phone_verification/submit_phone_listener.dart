import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/core/helpers/extensions.dart';
import 'package:just_chat/modules/auth/logic/verify_phone_number_cubit/auth_cubit.dart';
import 'package:just_chat/modules/auth/view/page/check_otp_page.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/constants/loties_assets.dart';

class SubmitPhoneListener extends StatelessWidget {
  const SubmitPhoneListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PhoneAuthCubit, PhoneAuthState>(
      listenWhen: (previous, current) =>
          current is SubmitNumberSuccess ||
          current is SubmitNumberFailure ||
          current is SubmitNumberLoading,
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
          Navigator.pop(context);
          context.pushReplacementNamed(OtpVerificationPage.routeName);
        } else if (state is SubmitNumberFailure) {
          Navigator.pop(context);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              animType: AnimType.rightSlide,
              title: 'Error Occured',
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
