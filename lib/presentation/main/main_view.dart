import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jarvis/app/app_prefs.dart';
import 'package:jarvis/app/di/di.dart';
import 'package:jarvis/data/network/app_api.dart';
import 'package:jarvis/presentation/chat/chat_view.dart';
import 'package:jarvis/presentation/chatbot/main_chatbot_view.dart';
import 'package:jarvis/presentation/common/bottom_navigation.dart';
import 'package:jarvis/presentation/common/loading_overlay.dart';
import 'package:jarvis/presentation/knowledge/knowledge_view.dart';
import 'package:jarvis/presentation/main/sign_in_kb_viewmodel.dart';
import 'package:jarvis/presentation/prompt/main_prompt_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _currentIndex = 0;
  List<Widget> body = [
    const ChatView(),
    const ChatBotMainView(),
    const PromptView(),
     KnowledgeView(),
  ];

  late final SignInKbViewModel _signInKbViewModel;
  late StreamSubscription _loadingSubscription;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initSignInKbViewModel();
  }

  void _initSignInKbViewModel() {
    _signInKbViewModel = getIt<SignInKbViewModel>();
    
    _loadingSubscription = _signInKbViewModel.outputIsLoading.listen((isLoading) {
      if (isLoading) {
        _isLoading = isLoading;
      }
    });
    
    _signInKbViewModel.start();
  }

  @override
  void dispose() {
    _loadingSubscription.cancel();
    _signInKbViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body[_currentIndex],
      // body: LoadingOverlay(
      //   isLoading: _isLoading,
      //   child: body[_currentIndex],
      // ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
