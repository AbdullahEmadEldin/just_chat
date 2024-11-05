import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/core/widgets/app_logo.dart';
import 'package:just_chat/core/widgets/main_button.dart';
import 'package:just_chat/modules/auth/logic/verify_phone_number_cubit/auth_cubit.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/loties_assets.dart';
import '../../../../core/theme/colors/colors_manager.dart';
import '../widgets/phone_verification/enter_phone_field.dart';
import '../widgets/phone_verification/policy_text.dart';
import '../widgets/phone_verification/submit_phone_listener.dart';

class PhoneAuthPage extends StatelessWidget {
  static const String routeName = '/phone_auth_page';
  const PhoneAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppLogo(),
              Text(
                AppStrings.verifyPhoneNumber.tr(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 6.0.h),
              Text(
                AppStrings.enterPhoneForVerification.tr(),
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: ColorsManager().colorScheme.grey80),
              ),
              SizedBox(height: 16.h),
              const EnterPhoneField(),
              SizedBox(height: 36.h),
              Center(child: Lottie.asset(LottiesAssets.unlock, width: 250.w)),
              SizedBox(height: 36.h),
              MainButton(
                  title: Text(
                    AppStrings.getVerificationCode.tr(),
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: ColorsManager().colorScheme.background,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    await context.read<PhoneAuthCubit>().validateAndVerify();
                  }),
              SizedBox(height: 16.h),
              const TermsAndConditionsText(),
              const SubmitPhoneListener(),
            ],
          ),
        ),
      ),
    );
  }
}
