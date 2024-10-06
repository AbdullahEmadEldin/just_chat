import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/modules/auth/view/page/phone_auth_page.dart';
import 'package:just_chat/modules/auth/view/widgets/otp_verification/otp_bloc_builder.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/constants/loties_assets.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/theme/colors/colors_manager.dart';
import '../../../../core/widgets/app_logo.dart';
import '../../logic/verify_phone_number_cubit/auth_cubit.dart';
import '../widgets/otp_verification/otp_verification_field.dart';

class OtpVerificationPage extends StatelessWidget {
  static const String routeName = '${PhoneAuthPage.routeName}/otp_verification';
  const OtpVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: AppLogo(),
            ),
            Text(
              'Enter 6-digit code',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              'We sent a code to phone number: ${getIt<PhoneAuthInfo>().phoneNumber}',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: ColorsManager().colorScheme.grey60,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: 36.h),
            const OtpVerificationField(),
            Center(child: Lottie.asset(LottiesAssets.shield, width: 400.w)),
            const Spacer(),
           OtpBlocBuilder(),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }
}
