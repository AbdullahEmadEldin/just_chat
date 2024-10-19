import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/modules/messages/view/widgets/messaging_text_field.dart';
import 'package:ripple_wave/ripple_wave.dart';

import '../../../core/theme/colors/colors_manager.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  double width = 70, height = 70;

  bool showRipple = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager().colorScheme.primary20,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: 
            GestureDetector(
              onLongPress: () {
                print('===,,,,,');
                setState(() {
                  height = 100;
                  width = 100;
                });
              },
              onLongPressEnd: (details) {
                setState(() {
                  height = 60;
                  width = 60;
                });
              },
              child: AnimatedContainer(
                width: width,
                height: height,
                duration: const Duration(milliseconds: 700),
                //  padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(64.r),
                  color: ColorsManager().colorScheme.fillGreen,
                ),
                child: Container(
                  width: 50,
                  height: 50,
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(64.r),
                    color: ColorsManager().colorScheme.primary,
                  ),
                  child: Icon(Icons.mic,
                      color: ColorsManager().colorScheme.background),
                ),
              ),
            ),
          
          ),
        ],
      ),
    );
  }
}
