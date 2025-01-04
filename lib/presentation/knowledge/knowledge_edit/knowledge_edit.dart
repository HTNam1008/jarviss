import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:jarvis/data/responses/ai_bot/get_assistants_response.dart';
import 'package:jarvis/presentation/common/bottom_navigation.dart';
import 'package:jarvis/presentation/common/chat_input_box.dart';
import 'package:jarvis/presentation/common/custome_header_bar.dart';
import 'package:jarvis/presentation/knowledge/knowledge_view.dart';
import 'package:jarvis/presentation/resources/color_manager.dart';
import 'package:jarvis/presentation/resources/font_manager.dart';
import 'package:jarvis/presentation/resources/values_manager.dart';

import '../../../data/responses/knowledge/get_knowledge_response.dart';

class EditKnowledgeView extends StatefulWidget {
  final KnowledgeData knowledge;

  const EditKnowledgeView({super.key, required this.knowledge});
  @override
  State<EditKnowledgeView> createState() => _EditKnowledgeViewState();
}

class _EditKnowledgeViewState extends State<EditKnowledgeView> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  late TextEditingController _nameController = TextEditingController();
  late TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    log(widget.knowledge.index);
    // Initialize the controllers with the knowledge data
    _nameController = TextEditingController(text: widget.knowledge.knowledgeName);
    _descriptionController = TextEditingController(text: widget.knowledge.description);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _handleUpdate() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await GetIt.instance<KnowledgeViewModel>().updatePrompt(
          widget.knowledge.index,
          _nameController.text,
          _descriptionController.text,
      );

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Knowledge updated successfully'))
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error updating knowledge: $e'))
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
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
        child: Form(
         key: _formKey,
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
                TextFormField(
                  controller: _nameController,
                  validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
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
                TextFormField(
                  controller: _descriptionController,
                  validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
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
                     onPressed: _isLoading ? null : () => Navigator.pop(context),
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
                    onPressed:  _isLoading ? null : _handleUpdate,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: AppPadding.p12),
                      backgroundColor: ColorManager.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSize.s12),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator()
                    :const Text(
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
    ),
    );
  }
}
