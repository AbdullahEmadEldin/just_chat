import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/core/widgets/app_logo.dart';
import 'package:just_chat/core/widgets/main_button.dart';
import 'package:just_chat/modules/auth/view/widgets/enter_phone_field.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/constants/loties_assets.dart';
import '../../../../core/theme/colors/colors_manager.dart';
import '../widgets/policy_text.dart';

class PhoneAuthPage extends StatelessWidget {
  static const String routeName = '/phone_auth_page';
  const PhoneAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppLogo(),
            Text(
              'Verify Phone Number',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 6.0.h),
            Text(
              'Enter your phone number, we will send you a verification code',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: ColorsManager().colorScheme.grey80),
            ),
            //const InputField(hintText: 'Enter your phone number'),
            SizedBox(height: 16.h),
            const EnterPhoneField(),
            SizedBox(height: 36.h),

            Center(child: Lottie.asset(LottiesAssets.unlock, width: 250.w)),
            const Spacer(),
            MainButton(title: 'Get Verification Code', onPressed: () {}),
            SizedBox(height: 16.h),
            const TermsAndConditionsText(),
          ],
        ),
      ),
    );
  }
}
