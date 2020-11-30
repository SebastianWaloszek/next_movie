import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract class PageBody<P extends PageBodyParameters> extends StatefulWidget {
  final P parameters;

  const PageBody(this.parameters);

  State createMobileState();

  State createWebState();

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() {
    if (kIsWeb) {
      return createWebState();
    } else {
      return createMobileState();
    }
  }
}

abstract class PageBodyParameters {
  final BuildContext context;

  PageBodyParameters({@required this.context}) : assert(context != null);
}
