import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/auth_cubit.dart';
import 'view/page/check_otp_page.dart';
import 'view/page/phone_auth_page.dart';

class AuthRouter {
  static late PhoneAuthCubit _authCubit;
  static Route? onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case PhoneAuthPage.routeName:
        _authCubit = PhoneAuthCubit();
        return PageRouteBuilder(
          transitionsBuilder: _authPagesAnimationBuilder,
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider(
            create: (context) => _authCubit,
            child: const PhoneAuthPage(),
          ),
        );
      case OtpVerificationPage.routeName:
        return PageRouteBuilder(
          transitionsBuilder: _authPagesAnimationBuilder,
          pageBuilder: (context, animation, secondaryAnimation) => BlocProvider(
            create: (context) => _authCubit,
            child: const OtpVerificationPage(),
          ),
        );
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
