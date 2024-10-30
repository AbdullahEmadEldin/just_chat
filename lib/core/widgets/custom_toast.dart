import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/colors/colors_manager.dart';

void showCustomToast(BuildContext context, String message,
    {bool isError = false}) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: MediaQuery.of(context).size.height * 0.8,
        left: MediaQuery.of(context).size.width * 0.1,
        right: MediaQuery.of(context).size.width * 0.1,
        child: Material(
          color: isError
              ? ColorsManager().colorScheme.fillRed
              : ColorsManager().colorScheme.fillGreen,
          shape: const StadiumBorder(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 18.0.w, vertical: 8.0.h),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );

    // Insert the overlay entry into the overlay
    overlay.insert(overlayEntry);

    // Remove the overlay entry after a delay
    Future.delayed(const Duration(milliseconds: 1000), () {
      overlayEntry.remove();
    });
  });
}
