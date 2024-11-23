import 'package:flutter/material.dart';
import 'package:jarvis/presentation/chat/chat_view.dart';
import 'package:jarvis/presentation/chatbot/main_chatbot_view.dart';
import 'package:jarvis/presentation/common/bottom_navigation.dart';
import 'package:jarvis/presentation/knowledge/knowledge_view.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body[_currentIndex],
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
