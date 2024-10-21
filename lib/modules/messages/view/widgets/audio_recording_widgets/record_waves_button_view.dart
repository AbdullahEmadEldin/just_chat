import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_chat/modules/messages/logic/recorder_cubit/recorder_cubit.dart';

import '../../../../../core/theme/colors/colors_manager.dart';

class CustomRecordingWaveWidget extends StatefulWidget {
  final IconData defaultIcon;
  const CustomRecordingWaveWidget({super.key, required this.defaultIcon});

  @override
  State<CustomRecordingWaveWidget> createState() => _RecordingWaveWidgetState();
}

class _RecordingWaveWidgetState extends State<CustomRecordingWaveWidget> {
  //

  final List<double> _heights = [
    0.02,
    0.04,
    0.1,
    0.4,
  ];
  Timer? _timer;

  @override
  void initState() {
    _startAnimating();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startAnimating() {
    _timer = Timer.periodic(const Duration(milliseconds: 150), (timer) {
      setState(() {
        // This is a simple way to rotate the list, creating a wave effect.
        _heights.add(_heights.removeAt(0));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecorderCubit, RecorderState>(
      buildWhen: (previous, current) =>
          current is UploadRecordUiTrigger ||
          current is RecorderViewTrigger ||
          current is RecorderViewClose,
      builder: (context, state) {
        if (state is UploadRecordUiTrigger) {
          return const CircularProgressIndicator(
            color: Colors.white,
          );
        }
        return AnimatedContainer(
          height: state is RecorderViewTrigger ? 47.h : 20.h,
          width: state is RecorderViewTrigger ? 47.w : 20.w,
          duration: const Duration(milliseconds: 100),
          child: context.read<RecorderCubit>().startRecordingAnimation
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _heights.map((height) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      width: 8,
                      height: 100.h * height,
                      // padding: const EdgeInsets.only(left: 12),
                      decoration: BoxDecoration(
                        color: ColorsManager().colorScheme.primary20,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    );
                  }).toList(),
                )
              : Icon(
                  widget.defaultIcon,
                  color: Colors.white,
                ),
        );
      },
    );
  }
}
