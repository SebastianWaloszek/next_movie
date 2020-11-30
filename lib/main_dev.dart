import 'package:flutter/widgets.dart';

import 'common/environments/environment.dart';
import 'common/environments/environment_dev.dart';
import 'common/utils/injector.dart';
import 'presentation/app.dart';

void main() {
  Environment.setCurrent(DevelopmentEnvironment());
  Injector.setup();
  runApp(MyApp());
}


