import 'package:flutter/material.dart';

class IgnorePointerOpacity extends StatelessWidget {
  final double opacity;
  final Widget child;

  const IgnorePointerOpacity({
    Key key,
    @required this.opacity,
    @required this.child,
  })  : assert(opacity != null),
        assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: opacity == 0.0,
      child: Opacity(
        opacity: opacity,
        child: child,
      ),
    );
  }
}
