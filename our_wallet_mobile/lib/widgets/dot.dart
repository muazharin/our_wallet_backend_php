import 'package:flutter/material.dart';

enum DotType { square, circle, diamond, icon }

class Dot extends StatelessWidget {
  final double? radius;
  final Color? color;
  final Widget? child;

  Dot({this.radius, this.color, this.child});

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: child,
      ),
    );
  }
}
