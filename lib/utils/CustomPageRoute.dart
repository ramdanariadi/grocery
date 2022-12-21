
import 'package:flutter/material.dart';
import 'package:grocery/constants/ApplicationColor.dart';

class CustomPageRoute<T> extends PageRoute<T> {
  CustomPageRoute({required this.child, int transitionDuration = 0}) {
    this.duration = transitionDuration;
  }
  final Widget child;
  late int duration;

  @override
  Color? get barrierColor => ApplicationColor.blackHint;

  @override
  String? get barrierLabel => '';

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(opacity: animation, child: this.child);
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(milliseconds: duration);
}
