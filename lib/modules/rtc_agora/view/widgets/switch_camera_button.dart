import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/colors/colors_manager.dart';
import '../../agora_service_cubit/agora_service_cubit.dart';

class SwitchCameraButton extends StatelessWidget {
  const SwitchCameraButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AgoraServiceCubit, AgoraServiceState>(
      buildWhen: (previous, current) => current is SwitchCamera,
      builder: (context, state) {
        final bool frontCamera =
            state is SwitchCamera ? state.frontCamera : true;
        return Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                frontCamera ? ColorsManager().colorScheme.grey50 : Colors.white,
          ),
          child: AnimatedRotation(
              turns: frontCamera ? 0 : 0.5,
              duration: const Duration(milliseconds: 300),
              child: Icon(
                CupertinoIcons.switch_camera,
                color:
                    !frontCamera ? ColorsManager().colorScheme.fillGreen : null,
              )),
        );
      },
    );
  }
}
