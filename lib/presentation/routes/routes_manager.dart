import 'package:curso_avanzado_flutter/app/di.dart';
import 'package:curso_avanzado_flutter/presentation/Views/forgot_password/forgot_password_view.dart';
import 'package:curso_avanzado_flutter/presentation/Views/login/login_view.dart';
import 'package:curso_avanzado_flutter/presentation/Views/main/main_view.dart';
import 'package:curso_avanzado_flutter/presentation/Views/main/pages/home_page/store_details_page/store_details_page.dart';
import 'package:curso_avanzado_flutter/presentation/Views/onboarding/onboarding_view.dart';
import 'package:curso_avanzado_flutter/presentation/Views/register/register_view.dart';
import 'package:curso_avanzado_flutter/presentation/Views/splash/splash_view.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static const String splashRoute = "/";
  static const String splashRouteName = "SplashView";
  static const String onBoardingRoute = "/onBoarding";
  static const String onBoardingRouteName = "OnboardingView";
  static const String loginRoute = "/login";
  static const String loginRouteName = "LoginView";
  static const String registerRoute = "/register";
  static const String registerRouteName = "RegisterView";
  static const String forgotPasswordRoute = "/forgotPassword";
  static const String forgotPasswordRouteName = "ForgotPasswordView";
  static const String mainRoute = "/main";
  static const String mainRouteName = "MainView";
  static const String storeDetailsRoute = "/main/storeDetails";
  static const String storeDetailsRouteName = "StoreDetailsPage";
}

class RoutesManager {
  static final routes = <GoRoute>[
    GoRoute(
      path: Routes.splashRoute,
      name: Routes.splashRouteName,
      builder: (context, state) => const SplashView(),
    ),
    GoRoute(
      path: Routes.onBoardingRoute,
      name: Routes.onBoardingRouteName,
      builder: (context, state) => const OnboardingView(),
    ),
    GoRoute(
      path: Routes.loginRoute,
      name: Routes.loginRouteName,
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: Routes.registerRoute,
      name: Routes.registerRouteName,
      builder: (context, state) {
        initRegisterModule();
        return const RegisterView();
      },
    ),
    GoRoute(
      path: Routes.forgotPasswordRoute,
      name: Routes.forgotPasswordRouteName,
      builder: (context, state) {
        initForgotPasswordModule();
        return const ForgotPasswordView();
      },
    ),
    GoRoute(
      path: Routes.mainRoute,
      name: Routes.mainRouteName,
      builder: (context, state) {
        initHomeModule();
        return const MainView();
      },
    ),
    GoRoute(
      path: Routes.storeDetailsRoute,
      name: Routes.storeDetailsRouteName,
      builder: (context, state) {
        initStoreDetailsModule();
        return const StoreDetailsPage();
      },
    ),
  ];
}

// class RouteGenerator {
//   static Route<dynamic> getRoute(RouteSettings routeSettings) {
//     switch (routeSettings.name) {
//       case Routes.splashRoute:
//         return MaterialPageRoute(builder: (_) => const SplashView());
//       case Routes.loginRoute:
//         initLoginModule();
//         return MaterialPageRoute(builder: (_) => const LoginView());
//       case Routes.onBoardingRoute:
//         return MaterialPageRoute(builder: (_) => const OnboardingView());
//       case Routes.registerRoute:
//         initRegisterModule();
//         return MaterialPageRoute(builder: (_) => const RegisterView());
//       case Routes.forgotPasswordRoute:
//         initForgotPasswordModule();
//         return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
//       case Routes.mainRoute:
//         initHomeModule();
//         return MaterialPageRoute(builder: (_) => const MainView());
//       case Routes.storeDetailsRoute:
//         initStoreDetailsModule();
//         return MaterialPageRoute(builder: (_) => const StoreDetailsPage());
//       default:
//         return unDefinedRoute();
//     }
//   }

//   static Route<dynamic> unDefinedRoute() {
//     return MaterialPageRoute(
//         builder: (_) => Scaffold(
//               appBar: AppBar(
//                 title: const Text(
//                   StringsManager.noRouteFound,
//                 ),
//               ),
//               body: const Center(
//                 child: Text(
//                   StringsManager.noRouteFound,
//                 ),
//               ),
//             ));
//   }
// }
