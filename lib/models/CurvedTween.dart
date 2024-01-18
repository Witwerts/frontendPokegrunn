import 'package:flutter/animation.dart';

class CurvedTween extends Tween<double> {
  CurvedTween({super.begin, super.end, required this.curve});

  final Curve curve;

  @override
  double lerp(double t) {
    final double curvedT = curve.transform(t);
    return super.lerp(curvedT);
  }
}