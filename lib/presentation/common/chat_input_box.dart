import 'package:flutter/material.dart';
import 'package:jarvis/presentation/resources/color_manager.dart';
import 'package:jarvis/presentation/resources/strings_manager.dart';
import 'package:jarvis/presentation/resources/values_manager.dart';

class ChatInputBox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  ChatInputBox({
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.s8, vertical: AppSize.s10),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s16)),
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: () {
              // Logic khi nhấn nút thêm
            },
          ),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: AppStrings.chatHintText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSize.s24),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: ColorManager.white,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: ColorManager.teal),
            onPressed: onSend,
          ),
        ],
      ),
    );
  }
}
