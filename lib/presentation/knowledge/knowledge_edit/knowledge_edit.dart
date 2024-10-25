import 'package:flutter/material.dart';
import 'package:jarvis/presentation/common/bottom_navigation.dart';
import 'package:jarvis/presentation/common/chat_input_box.dart';
import 'package:jarvis/presentation/common/custome_header_bar.dart';
import 'package:jarvis/presentation/resources/color_manager.dart';
import 'package:jarvis/presentation/resources/font_manager.dart';
import 'package:jarvis/presentation/resources/values_manager.dart';

class EditKnowledgeView extends StatefulWidget {
  @override
  State<EditKnowledgeView> createState() => _EditKnowledgeViewState();
}

class _EditKnowledgeViewState extends State<EditKnowledgeView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            const Text(
              'Edit knowledge',
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
                  'Name',
                  style: TextStyle(
                    fontSize: AppSize.s16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: AppSize.s8),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Input name',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSize.s12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.p16,
                      vertical: AppPadding.p12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSize.s16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Description',
                  style: TextStyle(
                    fontSize: AppSize.s16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: AppSize.s8),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    hintText: 'Input description',
                    hintStyle: TextStyle(
                      color: Colors.grey[400],
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSize.s12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.p16,
                      vertical: AppPadding.p12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSize.s24),
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
                      if (_nameController.text.isNotEmpty) {
                        Navigator.pop(context, {
                          'name': _nameController.text,
                          'description': _descriptionController.text,
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: AppPadding.p12),
                      backgroundColor: ColorManager.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSize.s12),
                      ),
                    ),
                    child: const Text(
                      'Confirm',
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
  }
}
