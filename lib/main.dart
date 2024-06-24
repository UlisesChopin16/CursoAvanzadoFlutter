import 'package:curso_avanzado_flutter/app/app.dart';
import 'package:curso_avanzado_flutter/app/di.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  runApp(MyApp());
}
