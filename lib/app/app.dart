import 'package:curso_avanzado_flutter/constants/theme_manager.dart';
import 'package:curso_avanzado_flutter/presentation/routes/routes_manager.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  // private named constructor
  const MyApp._internal();

  int get appState => 0;

  // single instance -- singleton
  static const MyApp instance = MyApp._internal();

  factory MyApp() => instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      theme: getApplicationTheme(),
    );
  }
}
