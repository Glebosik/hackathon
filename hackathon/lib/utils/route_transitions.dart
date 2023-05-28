import 'package:flutter/material.dart';

Route createRoute(Widget page, {String? name}) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 240),
    reverseTransitionDuration: const Duration(milliseconds: 240),
    settings: name != null ? RouteSettings(name: name) : null,
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route createRouteBackwards(Widget page) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 240),
    reverseTransitionDuration: const Duration(milliseconds: 240),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset.zero;
      const end = Offset(1.0, 0.0);
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
