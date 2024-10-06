import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/core/di/dependency_injection.dart';
import 'package:just_chat/modules/auth/logic/otp_verify_cubit/otp_verification_cubit.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../core/theme/colors/colors_manager.dart';

class OtpVerificationField extends StatelessWidget {
  const OtpVerificationField({super.key});

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      onCompleted: (otp) => context.read<OtpVerificationCubit>().verifyOtp(
            /// wouldn't be null as logic will not get here unless phone number is verified.
            verificationId: getIt<PhoneAuthInfo>().verificationId ?? '',
            otpCode: otp,
          ),
      cursorColor: ColorsManager().colorScheme.primary,
      autoFocus: true,
      appContext: context,
      textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: ColorsManager().colorScheme.primary,
          ),
      keyboardType: TextInputType.number,
      length: 6,
      obscureText: false,
      enableActiveFill: true,
      animationType: AnimationType.scale,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 60.h,
        fieldWidth: 50.w,
        activeColor: ColorsManager().colorScheme.primary,
        disabledColor: ColorsManager().colorScheme.primary,
        activeFillColor: ColorsManager().colorScheme.primary20.withOpacity(0.3),
        inactiveFillColor: ColorsManager().colorScheme.background,
        inactiveColor: ColorsManager().colorScheme.primary20,
        selectedColor: ColorsManager().colorScheme.primary,
        selectedFillColor: ColorsManager().colorScheme.primary40,
        errorBorderColor: ColorsManager().colorScheme.fillRed,
      ),
    );
  }
}
