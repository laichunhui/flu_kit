import 'package:flutter/material.dart';

class JColorWrapper {
  final Color _color;
  const JColorWrapper(this._color);

  Color opacity(double value) {
    assert(value >= 0.0 && value <= 1.0);
    return _color.withValues(alpha: (value * 255).round().toDouble());
  }
}

extension JColorExtension on Color {
  JColorWrapper get j => JColorWrapper(this);
}
