import 'package:curso_avanzado_flutter/app/di.dart';
import 'package:curso_avanzado_flutter/constants/strings_manager.dart';
import 'package:curso_avanzado_flutter/presentation/Views/forgot_password/forgot_password_view.dart';
import 'package:curso_avanzado_flutter/presentation/Views/login/login_view.dart';
import 'package:curso_avanzado_flutter/presentation/Views/main/main_view.dart';
import 'package:curso_avanzado_flutter/presentation/Views/onboarding/onboarding_view.dart';
import 'package:curso_avanzado_flutter/presentation/Views/register/register_view.dart';
import 'package:curso_avanzado_flutter/presentation/Views/splash/splash_view.dart';
import 'package:curso_avanzado_flutter/presentation/Views/store/store_details_view.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onBoarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgotPasswordRoute = "/forgotPassword";
  static const String mainRoute = "/main";
  static const String storeDetailsRoute = "/storeDetails";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      case Routes.registerRoute:
        // initRegisterModule();
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routes.forgotPasswordRoute:
        // initForgotPasswordModule();
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      case Routes.mainRoute:
        // initHomeModule();
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.storeDetailsRoute:
        // initStoreDetailsModule();
        return MaterialPageRoute(builder: (_) => const StoreDetailsView());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(
                  StringsManager.noRouteFound,
                ),
              ),
              body: const Center(
                child: Text(
                  StringsManager.noRouteFound,
                ),
              ),
            ));
  }
}
