import 'package:flutter/material.dart';
import 'package:jarvis/presentation/common/bottom_navigation.dart';
import 'package:jarvis/presentation/common/chat_input_box.dart';
import 'package:jarvis/presentation/common/custome_header_bar.dart';
import 'package:jarvis/presentation/resources/color_manager.dart';
import 'package:jarvis/presentation/resources/font_manager.dart';
import 'package:jarvis/presentation/resources/values_manager.dart';

class MainView extends StatefulWidget {
  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _currentIndex = 0;
  final TextEditingController _chatController = TextEditingController();

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    // Thực hiện logic điều hướng theo index (ví dụ: chuyển màn hình)
  }

  void _sendMessage() {
    String message = _chatController.text;
    if (message.isNotEmpty) {
      print('User message: $message');
      _chatController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: ColorManager.teal,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: ColorManager.white,
                  fontSize: AppSize.s24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {},
            ),
          ],
        ),
      ),
      appBar: CustomHeaderBar(
        centerWidget: DropdownButton<String>(
          value: 'GPT-4.0',
          dropdownColor: ColorManager.teal,
          style: TextStyle(color: ColorManager.white),
          underline: const SizedBox(),

          onChanged: (String? newValue) {

          },
          items: <String>['GPT-4.0', 'GPT-3.5', 'Gemini']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: AppSize.s8),
            padding: EdgeInsets.symmetric(
                horizontal: AppSize.s12, vertical: AppSize.s6),
            decoration: BoxDecoration(
              color: Colors.teal[400],
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Row(
              children: [
                Text('50',
                    style: TextStyle(
                        color: ColorManager.white, fontSize: AppSize.s16)),
                SizedBox(width: AppSize.s4),
                Icon(Icons.star, color: ColorManager.white, size: AppSize.s16),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
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
      ),
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
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
        contentPadding: const EdgeInsets.symmetric(horizontal: AppSize.s16, vertical: AppSize.s8),
      ),
    );
  }
}
