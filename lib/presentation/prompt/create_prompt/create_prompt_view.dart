import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:jarvis/presentation/common/animated_toggle_tab/animated_toggle_tab.dart';
import 'package:jarvis/presentation/common/dialog_util.dart';
import 'package:jarvis/presentation/resources/color_manager.dart';
import 'package:jarvis/presentation/resources/font_manager.dart';
import 'package:jarvis/presentation/resources/values_manager.dart';

import '../main_prompt_view.dart';

class CreatePromptView extends StatefulWidget {
  const CreatePromptView({super.key});

  @override
  State<CreatePromptView> createState() => _CreatePromptViewState();
}

class _CreatePromptViewState extends State<CreatePromptView> {
  bool _isPublicPrompts = false;
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _contentController = TextEditingController();
  String _selectedCategory = 'other';
  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _createPrompt() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await GetIt.instance<PromptViewModel>().createPrompt(
          _titleController.text,
          _contentController.text,
          _descriptionController.text,
          _selectedCategory,
          'English', // Default language
          _isPublicPrompts
      );

      Navigator.pop(context);
      showCustomDialog(
        context: context,
        type: DialogType.success,
        title: 'Success',
        message: 'Prompt created successfully',
      );
    } catch (e) {
      showCustomDialog(
        context: context,
        type: DialogType.error,
        title: 'Error',
        message: 'Failed to create prompt: $e',
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(AppSize.s16),
        width: 700,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
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
                      setState(() => _isPublicPrompts = i == 1);
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
                    activeStyle: const TextStyle(color: Colors.blue),
                    inactiveStyle: const TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: AppSize.s16),
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Name *',
                    hintText: 'Name of the prompt',
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSize.s16),
                DropdownButtonFormField<String>(
                    value: _selectedCategory,
                    decoration: const InputDecoration(
                      labelText: 'Category *',
                    ),
                    items: const [
                      DropdownMenuItem(value: 'other', child: Text('Other')),
                      DropdownMenuItem(value: 'marketing', child: Text('Marketing')),
                      DropdownMenuItem(value: 'business', child: Text('Business')),
                      DropdownMenuItem(value: 'writing', child: Text('Writing')),
                      DropdownMenuItem(value: 'coding', child: Text('Coding')),
                    ],
                    onChanged: (value) {
                      setState(() => _selectedCategory = value ?? 'other');
                    },
                  ),
                const SizedBox(height: AppSize.s16),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Description *',
                    hintText: 'Describe your prompt',
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSize.s16),
                TextFormField(
                  controller: _contentController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'Prompt *',
                    hintText: 'Enter prompt content',
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter prompt content';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSize.s16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: _isLoading ? null : () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: AppSize.s8),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _createPrompt,
                      child: _isLoading
                          ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                          : const Text('Create'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}