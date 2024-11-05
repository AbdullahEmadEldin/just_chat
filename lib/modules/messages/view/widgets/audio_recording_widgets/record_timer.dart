import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/core/constants/app_strings.dart';

import '../../../../../core/theme/colors/colors_manager.dart';

class RecordTimer extends StatelessWidget {
  final String recordTime;
  const RecordTimer({
    super.key,
    required this.recordTime,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: AppStrings.recording.tr(),
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: ColorsManager().colorScheme.grey80,
                  ),
            ),
            TextSpan(
              text: recordTime,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: ColorsManager().colorScheme.fillPrimary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
