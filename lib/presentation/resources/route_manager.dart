import 'package:flutter/material.dart';
import 'package:jarvis/presentation/forgot_password/forgot_password.dart';
import 'package:jarvis/presentation/getting_started/getting_started.dart';
import 'package:jarvis/presentation/login/login.dart';
import 'package:jarvis/presentation/main/main_view.dart';
import 'package:jarvis/presentation/register/register.dart';
import 'package:jarvis/presentation/resources/strings_manager.dart';
import 'package:jarvis/presentation/splash/splash.dart';
import 'package:jarvis/presentation/store_details/store_details.dart';

class Routes {
  static const String splashRoute = "/";
  static const String gettingStartedRoute = "/gettingStarted";
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
      case Routes.gettingStartedRoute:
        return MaterialPageRoute(builder: (_) => GettingStartedView());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routes.forgotPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => MainView());
      case Routes.storeDetailsRoute:
        return MaterialPageRoute(builder: (_) => const StoreDetailsView());
      default:
        return UndefinedRoute();
    }
  }

  static Route<dynamic> UndefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: Text(AppStrings.noRouteFound),
              ),
              body: Center(
                child: Text(AppStrings.noRouteFound),
              ),
            ));
  }
}
