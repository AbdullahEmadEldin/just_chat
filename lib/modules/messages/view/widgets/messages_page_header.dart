import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_chat/core/widgets/circle_cached_image.dart';
import 'package:just_chat/core/widgets/header_back_button.dart';
import 'package:just_chat/modules/messages/logic/messaging_cubit/messaging_cubit.dart';
import 'package:just_chat/modules/rtc_agora/video_call_page.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/constants/image_assets.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/services/firebase_notifiaction/firebase_cloud_msgs.dart';
import '../../../../core/services/firebase_notifiaction/firebase_msg_model.dart';
import '../../../../core/services/firestore_service.dart';
import '../../../../core/theme/colors/colors_manager.dart';

class MessagesPageHeader extends StatefulWidget {
  const MessagesPageHeader({super.key});

  @override
  State<MessagesPageHeader> createState() => _MessagesPageHeaderState();
}

class _MessagesPageHeaderState extends State<MessagesPageHeader> {
  late MessagingCubit _messagingCubit;
  @override
  void initState() {
    _messagingCubit = context.read<MessagingCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28.r),
          bottomRight: Radius.circular(28.r),
        ),
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      child: Row(
        children: [
          const HeaderBackButton(),
          SizedBox(width: 8.w),
          CircleCachedImage(
            imageUrl: _messagingCubit.opponentUser!.profilePicUrl!,
          ),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _messagingCubit.opponentUser!.name,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: ColorsManager().colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              _onlineStatus(context),
            ],
          ),
          const Spacer(),
          InkWell(
            onTap: () async {
              final senderName = await FirebaseGeneralServices.getUserById(
                getIt<FirebaseAuth>().currentUser!.uid,
              ).then((value) => value.name);

              ///Send Notification..
              ///
              await FcmService.sendNotification(
                FcmMsgModel(
                  remoteUserId: _messagingCubit.opponentUser!.uid,
                  opponentFcmToken: _messagingCubit.opponentUser!.fcmToken!,
                  senderName: senderName,
                  notificationType: NotificationType.call,
                  // chat id will be the channel id for the video call
                  chatId: _messagingCubit.chatId,
                ),
              ).then((value) {
                if (mounted) {
                  Navigator.of(context).pushNamed(
                    VideoCallPage.routeName,
                    arguments: _messagingCubit.chatId,
                  );
                }
              });
            },
            child: SvgPicture.asset(
              ImagesAssets.videoCallSvg,
              color: ColorsManager().colorScheme.primary,
            ),
          )
        ],
      ),
    );
  }

  Widget _onlineStatus(BuildContext context) {
    return StreamBuilder<Object>(
        stream: getIt<FirebaseFirestore>()
            .collection('users')
            .doc(_messagingCubit.opponentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox.shrink();
          }
          final DocumentSnapshot documentSnapshot =
              snapshot.data as DocumentSnapshot;
          final data = documentSnapshot.data() as Map<String, dynamic>?;

          final bool isOnline = data?['isOnline'] as bool;
          //
          final lastSeen = (data?['lastSeen'] as Timestamp);
          final formattedLastSeen = _handleLastSeenAppearance(lastSeen);
          //
          return Text(
            isOnline ? 'Online' : 'Last seen $formattedLastSeen',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: isOnline
                      ? ColorsManager().colorScheme.fillGreen
                      : ColorsManager().colorScheme.grey60,
                  fontWeight: FontWeight.bold, // fontWeight: FontWeight.bold,
                ),
          );
        });
  }

  String _handleLastSeenAppearance(Timestamp lastSeen) {
    final lastSeenDate = lastSeen.toDate();
    final now = DateTime.now();
    final difference = now.difference(lastSeenDate).inDays;

    if (difference == 0) {
      String formattedLastSeen = DateFormat('hh:mm a').format(lastSeenDate);
      return formattedLastSeen;
    } else {
      String formattedLastSeen = DateFormat('dd/MM/yyyy').format(lastSeenDate);
      return formattedLastSeen;
    }
  }
}
