import 'package:flutter/material.dart';

class IconGradient extends StatelessWidget {
  IconGradient({this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.purple, Colors.purple[800]],
        tileMode: TileMode.mirror,
      ).createShader(bounds),
      child: child,
    );
  }
}
