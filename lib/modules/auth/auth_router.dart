import 'package:flutter/material.dart';
import 'package:just_chat/modules/auth/view/page/phone_auth_page.dart';

class AuthRouter {
  static Route? onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case PhoneAuthPage.routeName:
        return PageRouteBuilder(
          transitionsBuilder: _authPagesAnimationBuilder,
          pageBuilder: (context, animation, secondaryAnimation) =>
              const PhoneAuthPage(),
        );
      default:
        return null;
    }
  }

  static Widget _authPagesAnimationBuilder(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
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
