import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/core/constants/app_strings.dart';

import '../../../../core/theme/colors/colors_manager.dart';
import '../../../../core/widgets/custom_toast.dart';
import '../../../../core/widgets/input_feild.dart';

class ProfilePhoneNumber extends StatelessWidget {
  final String phoneNumber;
  const ProfilePhoneNumber({
    super.key,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return InputField(
      hintText: AppStrings.phone.tr(),
      backgroundColor: ColorsManager().colorScheme.background,
      suffixIcon: IconButton(
        onPressed: () {
          Clipboard.setData(
            ClipboardData(
              text: phoneNumber,
            ),
          );
          showCustomToast(
            context,
            AppStrings.copiedMessage.tr(),
          );
        },
        icon: Icon(
          Icons.copy,
          size: 20.r,
          color: ColorsManager().colorScheme.primary40,
        ),
      ),
      readOnly: true,
      controller: TextEditingController(text: phoneNumber),
    );
  }
}
