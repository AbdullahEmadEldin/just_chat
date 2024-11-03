import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/services/cache/cache_helper.dart';
import '../../../../core/theme/colors/colors_manager.dart';
import '../../../../core/widgets/custom_toast.dart';

class NotificationSwitcher extends StatefulWidget {
  const NotificationSwitcher({super.key});

  @override
  State<NotificationSwitcher> createState() => _NotificationSwitcherState();
}

class _NotificationSwitcherState extends State<NotificationSwitcher> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Transform.scale(
        scale: 1.2,
        child: Switch(
          splashRadius: 40,
          activeTrackColor: ColorsManager().colorScheme.fillGreen,
          thumbIcon: WidgetStateProperty.all(
            Icon(
              CupertinoIcons.bell_fill,
              color: CacheHelper.getData(key: SharedPrefKeys.notification)
                  ? Colors.white
                  : ColorsManager().colorScheme.grey70,
              // size: 20,
            ),
          ),
          inactiveTrackColor: ColorsManager().colorScheme.grey40,
          trackOutlineColor:
              WidgetStateProperty.resolveWith((final Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return null;
            } else {
              return Colors.transparent;
            }
          }),
          value: CacheHelper.getData(key: SharedPrefKeys.notification) ?? true,
          onChanged: (value) {
            CacheHelper.saveData(key: SharedPrefKeys.notification, value: value)
                .then((value) {
              showCustomToast(
                context,
                'Restart app to take effect',
              );
            });
            setState(() {});
          },
        ),
      ),
    );
  }
}