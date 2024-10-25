import 'package:flutter/material.dart';
import 'package:jarvis/presentation/common/chat_input_box.dart';
import 'package:jarvis/presentation/resources/color_manager.dart';
import 'package:jarvis/presentation/resources/font_manager.dart';
import 'package:jarvis/presentation/resources/values_manager.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController _chatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSize.s16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hi, good afternoon!',
                    style: TextStyle(
                        fontSize: AppSize.s24,
                        fontWeight: FontWeightManager.bold),
                  ),
                  SizedBox(height: AppSize.s8),
                  Text(
                    'I\'m a chatbot.',
                    style: TextStyle(
                        fontSize: AppSize.s16, color: ColorManager.grey),
                  ),
                  SizedBox(height: AppSize.s20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildUploadButton(
                        icon: Icons.image,
                        label: 'Upload your image',
                        color: Colors.teal.shade100,
                      ),
                      _buildUploadButton(
                        icon: Icons.folder,
                        label: 'Upload your file',
                        color: Colors.blue.shade100,
                      ),
                    ],
                  ),
                  SizedBox(height: AppSize.s20),
                  Text('You can ask me like this',
                      style: TextStyle(fontSize: AppSize.s18)),
                  SizedBox(height: AppSize.s10),
                  ListView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      _buildSuggestion(
                          'Write an email', 'to submission project'),
                      _buildSuggestion('Suggest events', 'for this summer'),
                      _buildSuggestion('List some books',
                          'related to adventure'),
                      _buildSuggestion('Explain an issue',
                          'why the earth is round'),
                    ],
                  ),
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
    );
  }

  Widget _buildUploadButton({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return GestureDetector(
      onTap: () {
        // Logic khi nhấn nút upload
      },
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(AppSize.s16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: AppSize.s40),
            SizedBox(height: AppSize.s8),
            Text(label),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestion(String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppSize.s8),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        tileColor: Colors.teal.shade50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s10),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: AppSize.s16),
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
