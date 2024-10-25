import 'package:flutter/material.dart';
import 'package:jarvis/presentation/common/bottom_navigation.dart';
import 'package:jarvis/presentation/common/chat_input_box.dart';
import 'package:jarvis/presentation/common/custome_header_bar.dart';
import 'package:jarvis/presentation/resources/color_manager.dart';
import 'package:jarvis/presentation/resources/font_manager.dart';
import 'package:jarvis/presentation/resources/values_manager.dart';

class DeleteKnowledgeView extends StatelessWidget {
  final String? knowledgeName;

  const DeleteKnowledgeView({
    Key? key,
    this.knowledgeName,
  }) : super(key: key);

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
            Container(
              width: AppSize.s60,
              height: AppSize.s60,
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.delete_outline,
                size: AppSize.s32,
                color: Colors.red[400],
              ),
            ),
            const SizedBox(height: AppSize.s20),
            const Text(
              'Remove Knowledge',
              style: TextStyle(
                fontSize: AppSize.s20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSize.s12),
            Text(
              'Are you sure you want to remove "$knowledgeName"?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: AppSize.s16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: AppSize.s24),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: AppPadding.p12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSize.s12),
                      ),
                      backgroundColor: Colors.grey[100],
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: AppSize.s16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSize.s16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: AppPadding.p12),
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSize.s12),
                      ),
                    ),
                    child: const Text(
                      'Remove',
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