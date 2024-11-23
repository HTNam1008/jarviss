import 'package:flutter/material.dart';
import 'package:jarvis/presentation/chatbot/chat/chat_bot_view.dart';
import 'package:jarvis/presentation/chatbot/create_bot/create_bot_view.dart';
import 'package:jarvis/presentation/chatbot/edit_bot/edit_bot_view.dart';
import 'package:jarvis/presentation/chatbot/main_chatbot_view.dart';
import 'package:jarvis/presentation/chatbot/preview_bot/preview_bot.dart';
import 'package:jarvis/presentation/authencation/forgot_password/forgot_password.dart';
import 'package:jarvis/presentation/getting_started/getting_started.dart';
import 'package:jarvis/presentation/knowledge/knowledge_create/knowledge_create.dart';
import 'package:jarvis/presentation/knowledge/knowledge_delete/knowledge_delete.dart';
import 'package:jarvis/presentation/knowledge/knowledge_detail/knowledge_detail.dart';
import 'package:jarvis/presentation/knowledge/knowledge_edit/knowledge_edit.dart';
import 'package:jarvis/presentation/authencation/sign_in/sign_in.dart';
import 'package:jarvis/presentation/main/main_view.dart';
import 'package:jarvis/presentation/profile/detail_profile_view.dart';
import 'package:jarvis/presentation/profile/profile_view.dart';
import 'package:jarvis/presentation/prompt/create_prompt/create_prompt_view.dart';
import 'package:jarvis/presentation/prompt/main_prompt_view.dart';
import 'package:jarvis/presentation/authencation/sign_up/sign_up.dart';
import 'package:jarvis/presentation/resources/strings_manager.dart';
import 'package:jarvis/presentation/splash/splash.dart';
import 'package:jarvis/presentation/upgrade/upgrade.dart';

class Routes {
  static const String splashRoute = "/";
  static const String gettingStartedRoute = "/gettingStarted";
  static const String onBoardingRoute = "/onBoarding";
  static const String signInRoute = "/sign-in";
  static const String signUpRoute = "/sign-up";
  static const String forgotPasswordRoute = "/forgot-password";
  static const String mainRoute = "/main";
  static const String chatbotMainRoute = "/chatbotMain";
  static const String chatbotRoute = "/chatbot";
  static const String profileRoute = "/profile";
  static const String detailProfileRoute = "/detailProfile";
  static const String createBotRoute = "/createBot";
  static const String previewBotRoute = "/previewBot";
  static const String editBotRoute = "/editBot";
  static const String promptRoute = "/prompt";
  static const String createPromptRoute = "/createPrompt";
  static const String createKnowledgeRoute = "/createKnowledge";
  static const String editKnowledgeRoute = "/editKnowledge";
  static const String deleteKnowledgeRoute = "/deleteKnowledge";
  static const String detailKnowledgeRoute = "/detailKnowledge";
  static const String upgradeProRoute = "/upgradePro";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => SplashView());
      case Routes.gettingStartedRoute:
        return MaterialPageRoute(builder: (_) => GettingStartedView());
      case Routes.signInRoute:
        return MaterialPageRoute(builder: (_) => const SignInView());
      case Routes.signUpRoute:
        return MaterialPageRoute(builder: (_) => const SignUpView());
      case Routes.forgotPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.chatbotMainRoute:
        return MaterialPageRoute(builder: (_) => const ChatBotMainView());
      case Routes.chatbotRoute:
        return MaterialPageRoute(builder: (_) => const ChatBotView());
      case Routes.profileRoute:
        return MaterialPageRoute(builder: (_) => const ProfileView());
      case Routes.detailProfileRoute:
        return MaterialPageRoute(builder: (_) => const DetailProfileView());
      case Routes.createBotRoute:
        return MaterialPageRoute(builder: (_) => const CreateBotView());
      case Routes.previewBotRoute:
      return MaterialPageRoute(builder: (_) => const PreviewBotView());
      case Routes.editBotRoute:
        return MaterialPageRoute(builder: (_) => const EditBotView());
      case Routes.promptRoute:
        return MaterialPageRoute(builder: (_) => const PromptView());
      case Routes.createPromptRoute:
        return MaterialPageRoute(builder: (_) => CreatePromptView());
      case Routes.createKnowledgeRoute:
        return MaterialPageRoute(builder: (_) => CreateKnowledgeView());
      case Routes.deleteKnowledgeRoute:
        return MaterialPageRoute(builder: (_) => DeleteKnowledgeView());
      case Routes.editKnowledgeRoute:
        return MaterialPageRoute(builder: (_) => EditKnowledgeView());
      case Routes.detailKnowledgeRoute:
        return MaterialPageRoute(builder: (_) => DetailKnowledgeView());
      case Routes.upgradeProRoute:
        return MaterialPageRoute(builder: (_) => UpgradeView());
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
