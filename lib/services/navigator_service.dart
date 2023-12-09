import 'package:flutter/material.dart';

void navigatorPush(BuildContext context, dynamic route) {
  Navigator.push(
    context,
    pageRouteBuilder(context, route),
  );
}

void navigatorPushReplacement(BuildContext context, dynamic route) {
  Navigator.pushReplacement(
    context,
    pageRouteBuilder(context, route),
  );
}

PageRouteBuilder pageRouteBuilder(BuildContext context, dynamic route) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 500),
    pageBuilder: (context, animation, secondaryAnimation) {
      return route;
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}
