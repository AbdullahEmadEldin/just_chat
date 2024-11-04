import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      hintText: 'Phone number',
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
            'Copied message',
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
