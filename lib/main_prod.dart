import 'package:flutter/widgets.dart';

import 'common/environments/environment.dart';
import 'common/environments/environment_prod.dart';
import 'common/utils/injector.dart';
import 'presentation/app.dart';

void main() {
  Environment.setCurrent(ProductionEnvironment());
  Injector.setup();
  runApp(MyApp());
}
