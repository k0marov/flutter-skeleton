import 'package:flutter/material.dart';

import '../di.dart';
import '../logic/core/theme_brightness/theme_brightness.dart';
import 'core/auth/auth_gate.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  ThemeMode _getThemeMode(ThemeBrightness brightness) {
    switch (brightness) {
      case ThemeBrightness.dark:
        return ThemeMode.dark;
      case ThemeBrightness.light:
        return ThemeMode.light;
      case ThemeBrightness.unset:
        return ThemeMode.system;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ThemeBrightness>(
        stream: uiDeps.getBrightnessStream(),
        builder: (context, brightness) {
          return MaterialApp(
            title: 'Avencia',
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: _getThemeMode(brightness.data ?? ThemeBrightness.unset),
            home: AuthGate(),
          );
        });
  }
}
