import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'injector.dart';

class BlocWrapper {
  Widget widget;

  BlocWrapper(this.widget);

  Widget build() => widget;

  BlocWrapper withBloc<T extends Bloc>() {
    widget = BlocProvider<T>(
      create: (BuildContext context) => Injector.resolve<T>(),
      child: widget,
    );
    return this;
  }
}
