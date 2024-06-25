import 'dart:async';

import 'package:curso_avanzado_flutter/app/app_preferences.dart';
import 'package:curso_avanzado_flutter/app/di.dart';
import 'package:curso_avanzado_flutter/constants/assets_manager.dart';
import 'package:curso_avanzado_flutter/constants/color_manager.dart';
import 'package:curso_avanzado_flutter/presentation/routes/routes_manager.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final AppPreferences _appPreferences = instance<AppPreferences>();

  Timer? _timer;

  void _startTimer() {
    _timer = Timer(const Duration(seconds: 2), _goNext);
  }

  void _goNext() {
    if (!_appPreferences.isOnBoardingScreenViewed()) {
      Navigator.pushReplacementNamed(context, Routes.onBoardingRoute);
      return;
    } 
    if (!_appPreferences.isUserLoggedIn()) {
      Navigator.pushReplacementNamed(context, Routes.loginRoute);
      return;
    }
    Navigator.pushReplacementNamed(context, Routes.mainRoute);
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorManager.primary,
      body: Center(
        child: Image(
          image: AssetImage(
            ImageAssets.splashLogo,
          ),
        ),
      ),
    );
  }
}
