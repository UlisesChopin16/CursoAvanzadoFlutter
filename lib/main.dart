import 'package:curso_avanzado_flutter/app/app.dart';
import 'package:curso_avanzado_flutter/app/di.dart';
import 'package:curso_avanzado_flutter/constants/language_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initAppModule();
  runApp(
    ProviderScope(
      child: EasyLocalization(
        supportedLocales: const [ENGLISH_LOCAL, ARABIC_LOCAL, SPANISH_LOCAL],
        path: ASSETS_PATH_LOCALISATIONS,
        child: Phoenix(child: MyApp()),
      ),
    ),
  );
}
