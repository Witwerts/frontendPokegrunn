import 'package:flutter/animation.dart';

class CurvedTween extends Tween<double> {
  CurvedTween({double? begin, double? end, required this.curve})
      : super(begin: begin, end: end);

  final Curve curve;

  @override
  double lerp(double t) {
    final double curvedT = curve.transform(t);
    return super.lerp(curvedT);
  }
}