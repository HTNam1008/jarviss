import 'package:flutter/material.dart';
import 'package:jarvis/presentation/common/chat_input_box.dart';
import 'package:jarvis/presentation/common/custome_header_bar.dart';
import 'package:jarvis/presentation/resources/color_manager.dart';
import 'package:jarvis/presentation/resources/font_manager.dart';
import 'package:jarvis/presentation/resources/values_manager.dart';

class PreviewBotView extends StatefulWidget {
  const PreviewBotView({super.key});

  @override
  State<PreviewBotView> createState() => _PreviewBotViewState();
}

class _PreviewBotViewState extends State<PreviewBotView> {
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
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: ColorManager.teal, // Text color
                  padding: EdgeInsets.symmetric(horizontal: AppSize.s8, vertical: AppSize.s4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded corners
                  ),
                ),
                onPressed: () {
                  showDialog(context: context, builder: (builder) {
                    return Dialog(
                      insetPadding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSize.s20),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(AppPadding.p20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Save New Bot',
                              style: TextStyle(
                                fontSize: AppSize.s20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: AppSize.s20),
                            Container(
                              width: AppSize.s60,
                              height: AppSize.s60,
                              decoration: BoxDecoration(
                                color: ColorManager.teal.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(AppSize.s12),
                              ),
                              child: Icon(
                                Icons.layers_outlined,
                                size: AppSize.s32,
                                color: ColorManager.teal,
                              ),
                            ),
                            const SizedBox(height: AppSize.s20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Do you want to save this bot?',
                                  style: TextStyle(
                                    fontSize: AppSize.s16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(vertical: AppPadding.p12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(AppSize.s12),
                                      ),
                                      backgroundColor: ColorManager.teal.withOpacity(0.1),
                                    ),
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(
                                        color: ColorManager.teal,
                                        fontSize: AppSize.s16,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: AppSize.s16),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Handle confirm action
                                      Navigator.pop(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(vertical: AppPadding.p12),
                                      backgroundColor: ColorManager.teal,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(AppSize.s12),
                                      ),
                                    ),
                                    child: const Text(
                                      'Save',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: AppSize.s16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            },
              child: Text("Save")
            ),
          )
        ],
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
