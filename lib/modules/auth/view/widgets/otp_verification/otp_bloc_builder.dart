import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_chat/core/helpers/extensions.dart';
import 'package:just_chat/modules/auth/logic/cubit/otp_verification_cubit.dart';
import 'package:just_chat/modules/auth/view/page/fill_data_page.dart';
import 'package:just_chat/modules/chat/view/all_chats_page.dart';

import '../../../../../core/theme/colors/colors_manager.dart';
import '../../../../../core/widgets/main_button.dart';

class OtpBlocBuilder extends StatelessWidget {
  const OtpBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OtpVerificationCubit, OtpVerificationState>(
      builder: (context, state) {
        if (state is OtpVerificationFailure) {
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
        } else if (state is OtpVerificationSuccess) {
          _handleNavigationAfterOtp(context, isNewUser: state.isNewUser);
        }
        return MainButton(
          title: state is OtpVerificationLoading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(
                  'Verify Code',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: ColorsManager().colorScheme.background,
                      fontWeight: FontWeight.bold),
                ),
          onPressed: () {
            // Navigator.pushReplacementNamed(context, PhoneAuthPage.routeName);
          },
        );
      },
    );
  }

  _handleNavigationAfterOtp(BuildContext context, {required bool isNewUser}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {

    if (isNewUser) {
      context.pushReplacementNamed(FillDataPage.routeName);
    } else {
      context.pushReplacementNamed(AllChatsPage.routeName);
    }
    });
  }
}
