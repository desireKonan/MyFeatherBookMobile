import 'package:flutter/material.dart';

class MyFeatherTransitionPage extends PageRouteBuilder {
  final Widget child;
  MyFeatherTransitionPage({required this.child})
      : super(
            transitionDuration: const Duration(seconds: 2),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secAnimation,
                Widget widget) {
              animation = CurvedAnimation(
                  parent: animation, curve: Curves.elasticInOut);

              return ScaleTransition(
                scale: animation,
                alignment: Alignment.center,
                child: widget,
              );
            },
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secAnimation) {
              return child;
            });
}
