import 'package:flutter/material.dart';
import 'package:jarvis/presentation/common/animated_toggle_tab/animated_toggle_tab.dart';
import 'package:jarvis/presentation/resources/color_manager.dart';
import 'package:jarvis/presentation/resources/font_manager.dart';
import 'package:jarvis/presentation/resources/values_manager.dart';

class CreatePromptView extends StatefulWidget {
  const CreatePromptView({super.key});

  @override
  State<CreatePromptView> createState() => _CreatePromptViewState();
}

class _CreatePromptViewState extends State<CreatePromptView> {
  bool _isPublicPrompts = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(AppSize.s8),
        width: 700,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "New Prompt",
              style: TextStyle(
                fontWeight: FontWeightManager.bold,
                fontSize: AppSize.s16,
                fontFamily: FontConstants.fontFamily,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: AppSize.s8),
              child: AppinioAnimatedToggleTab(
                callback: (int i) {
                  setState(() {
                    _isPublicPrompts = !_isPublicPrompts;
                  });
                },
                tabTexts: const [
                  'Private Prompt',
                  'Public Prompt',
                ],
                height: 40,
                width: 300,
                boxDecoration: BoxDecoration(
                  color: ColorManager.primary,
                  borderRadius: BorderRadius.circular(AppSize.s8),
                ),
                animatedBoxDecoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFc3d2db).withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(2, 2),
                    ),
                  ],
                  color: ColorManager.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(AppSize.s8),
                  ),
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                activeStyle: const TextStyle(
                  color: Colors.blue,
                ),
                inactiveStyle: const TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: AppSize.s8),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Name *',
                hintText: 'Name of the prompt',
                border: OutlineInputBorder(),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            _isPublicPrompts ? const SizedBox(height: AppSize.s8) : const SizedBox(),
            _isPublicPrompts
                ? const TextField(
                    decoration: InputDecoration(
                      labelText: 'Category *',
                      hintText: 'Select a category',
                      border: OutlineInputBorder(),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  )
                : const SizedBox(),
            const SizedBox(height: AppSize.s8),
            const TextField(
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Description',
                hintText: 'Describe your prompt so others can have a better understanding',
                border: OutlineInputBorder(),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            const SizedBox(height: AppSize.s8),
            const TextField(
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Prompt *',
                hintText: 'Use square brackets [ ] to specify user input.',
                border: OutlineInputBorder(),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Cancel action
                  },
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: AppSize.s8),
                ElevatedButton(
                  onPressed: () {
                    // Handle create prompt action
                  },
                  child: const Text('Create'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
