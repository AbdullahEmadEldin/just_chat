import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/colors/colors_manager.dart';

class AllChatsHeaderCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final painterGradient = LinearGradient(
      colors: [
        ColorsManager().colorScheme.primary80,
        const Color.fromARGB(255, 18, 150, 186),
      ],
    );
    final paint = Paint()
      ..color = ColorsManager().colorScheme.primary80
      ..shader = painterGradient.createShader(Rect.fromLTWH(0, 0, 200, 200))
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 180)
      //! Rect 2
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            63.w,
            15.h,
            150.w,
            60.h,
          ), // Define the rectangle dimensions and position
          Radius.circular(45.r), // Rounded corners with radius
        ),
      )

      // ..conicTo(0, 100, 4, 20, 0.5)
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(
          60.w,
          25.h,
          30.w,
          10.h,
        ),
        Radius.circular(45.r),
      ))
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(
          60.w,
          55.h,
          30.w,
          10.h,
        ),
        Radius.circular(45.r),
      ))
      //! Circle
      ..addArc(
        Rect.fromCircle(center: Offset(45.w, 45.h), radius: 30.r),
        0,
        45,
      )
      // ..conicTo(0, 100, 4, 20, 0.5)
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(
          0,
          25,
          30.w,
          10.h,
        ),
        Radius.circular(45.r),
      ))
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(
          0,
          60,
          30.w,
          10.h,
        ),
        Radius.circular(45.r),
      ))
      //! Rect 1
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            -120.w,
            15.h,
            150.w,
            60.h,
          ), // Define the rectangle dimensions and position
          Radius.circular(45.r), // Rounded corners with radius
        ),
      )
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
