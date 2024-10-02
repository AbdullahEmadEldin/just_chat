import 'package:flutter/material.dart';
import 'package:just_chat/modules/auth/view/page/phone_auth_page.dart';

import '../../../../core/widgets/app_logo.dart';

class OtpVerificationPage extends StatelessWidget {
  static const String routeName = '${PhoneAuthPage.routeName}/otp_verification';
  const OtpVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [Center(child: AppLogo())],
        ),
      ),
    );
  }
}
