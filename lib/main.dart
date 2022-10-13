import 'package:flutter/material.dart';

import 'di.dart' as di;
import 'ui/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.initialize();
  runApp(const MyApp());
}
