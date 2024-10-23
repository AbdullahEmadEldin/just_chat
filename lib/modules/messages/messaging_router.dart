import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_chat/modules/messages/view/widgets/image_widgets/preview_image.dart';

import 'logic/messaging_cubit/messaging_cubit.dart';
import 'logic/recorder_cubit/recorder_cubit.dart';
import 'view/pages/messaging_page.dart';

class MessagingRouter {
  static Route? onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case MessagingPage.routeName:
        final args = settings.arguments as MessagingPageArgs;
        return PageRouteBuilder(
            transitionsBuilder: _authPagesAnimationBuilder,
            pageBuilder: (context, animation, secondaryAnimation) =>
                MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => MessagingCubit(chatModel: args.chat)
                        ..opponentUser = args.opponentUser,
                    ),
                    BlocProvider(
                      create: (context) => RecorderCubit(),
                    ),
                  ],
                  child: MessagingPage(args: args),
                ));
      case PreviewImageScreen.routeName:
        final args = settings.arguments as ImagePreviewArgs;
        return MaterialPageRoute(
            builder: (context) => PreviewImageScreen(args: args));
      default:
        return null;
    }
  }

  static Widget _authPagesAnimationBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.ease;
    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: curve,
      reverseCurve: Curves.bounceInOut,
    );
    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    return SlideTransition(
      position: tween.animate(curvedAnimation),
      child: child,
    );
  }
}
