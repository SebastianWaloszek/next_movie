import 'dart:ui';

import 'package:flutter/material.dart';

class ThemedColor {
  final Color light;
  final Color dark;

  const ThemedColor({
    @required this.light,
    @required this.dark,
  })  : assert(light != null),
        assert(dark != null);

  Color getColor(BuildContext context) {
    switch (Theme.of(context).brightness) {
      case Brightness.light:
        return light;
      case Brightness.dark:
        return dark;
    }
    throw UnsupportedError('${Theme.of(context).brightness} is not supported');
  }
}
