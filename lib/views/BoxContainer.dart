import 'package:flutter/material.dart';

class BoxContainer extends Container {
  BoxContainer({
    super.key,
    color,
    alignment,
    width,
    padding,
    margin,
    decoration,
    child,
  }) : super(
            alignment: alignment ?? Alignment.topLeft,
            margin: margin ?? const EdgeInsets.all(0),
            width: width ?? double.maxFinite,
            padding: padding ?? const EdgeInsets.all(12),
            decoration: decoration ??
                BoxDecoration(
                  color: color ?? Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  border: Border.all(
                    color: Colors.black.withOpacity(0.4),
                    width: 1,
                  ),
                ),
            child: child);
}
