import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:jarvis/presentation/chatbot/create_bot/create_bot_view.dart';
import 'package:jarvis/presentation/chatbot/edit_bot.dart';
import 'package:jarvis/presentation/chatbot/main_chatbot_view.dart';
import 'package:jarvis/presentation/forgot_password/forgot_password.dart';
import 'package:jarvis/presentation/getting_started/getting_started.dart';
import 'package:jarvis/presentation/login/login.dart';
import 'package:jarvis/presentation/main/main_view.dart';
import 'package:jarvis/presentation/profile/detail_profile.dart';
import 'package:jarvis/presentation/profile/profile.dart';
import 'package:jarvis/presentation/register/register.dart';
import 'package:jarvis/presentation/resources/strings_manager.dart';
import 'package:jarvis/presentation/splash/splash.dart';
import 'package:jarvis/presentation/store_details/store_details.dart';
import 'package:jarvis/presentation/knowledge_view/knowledge_view.dart';
import 'package:jarvis/presentation/knowledge_detail/knowledge_detail.dart';
import 'package:jarvis/presentation/knowledge_add/knowledge_add.dart';
import 'package:jarvis/presentation/knowledge_delete/knowledge_delete.dart';
import 'package:jarvis/presentation/unit_add/unit_add.dart';
import 'package:jarvis/presentation/unit_add/unit_add_localfile.dart';
import 'package:jarvis/presentation/unit_add/unit_add_website.dart';



class Routes {
  static const String splashRoute = "/";
  static const String gettingStartedRoute = "/gettingStarted";
  static const String onBoardingRoute = "/onBoarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgotPasswordRoute = "/forgotPassword";
  static const String mainRoute = "/main";
  static const String chatbotRoute = "/chatbotRoute";
  static const String profileRoute = "/profile";
  static const String detailProfileRoute = "/detailProfile";
  static const String createBotRoute = "/createBot";
  static const String editBotRoute = "/editBot";
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
      case Routes.chatbotRoute:
        return MaterialPageRoute(builder: (_) => ChatbotView());
      case Routes.profileRoute:
        return MaterialPageRoute(builder: (_) => const ProfileView());
      case Routes.detailProfileRoute:
        return MaterialPageRoute(builder: (_) => const DetailProfileView());
      case Routes.createBotRoute:
        return MaterialPageRoute(builder: (_) => const CreateBotView());
      case Routes.editBotRoute:
        return MaterialPageRoute(builder: (_) => const EditBotView());
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
