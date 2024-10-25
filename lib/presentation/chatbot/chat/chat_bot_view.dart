import 'package:flutter/material.dart';
import 'package:jarvis/presentation/common/chat_input_box.dart';
import 'package:jarvis/presentation/common/custome_header_bar.dart';
import 'package:jarvis/presentation/resources/font_manager.dart';
import 'package:jarvis/presentation/resources/values_manager.dart';

class ChatBotView extends StatefulWidget {
  const ChatBotView({super.key});

  @override
  State<ChatBotView> createState() => _ChatBotViewState();
}

class _ChatBotViewState extends State<ChatBotView> {
  final TextEditingController _chatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomHeaderBar(
        centerWidget: const Text(
          'Name Bot',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 30.0),
                      child: Center(
                        child: CircleAvatar(
                          radius: 40.0,
                          backgroundImage: AssetImage('assets/images/avt.png'),
                        ),
                      ),
                    ),
                    SizedBox(height: AppSize.s8),
                    Center(
                      child: Text("Description", style: TextStyle(
                        fontSize: AppSize.s16,
                        fontWeight: FontWeightManager.medium,
                      ),),
                    )
                  ],
                ),
              ),
            ),
            ChatInputBox(
              controller: _chatController,
              onSend: _sendMessage,
            ),
          ],
        ),
      ),
    );
  }
  
  void _sendMessage() {
    String message = _chatController.text;
    if (message.isNotEmpty) {
      _chatController.clear();
    }
  }
}
