import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:memoire/config/router/routes.dart';
import 'package:memoire/config/themes/themes.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightColorScheme, darkColorScheme) {
        return MaterialApp.router(
          title: 'Memoire',
          theme: AppTheme.light(lightColorScheme),
          darkTheme: AppTheme.dark(darkColorScheme),
          themeMode: ThemeMode.system,
          routerDelegate: appRouter.delegate(),
          routeInformationParser: appRouter.defaultRouteParser(),
        );
      },
    );
  }
}