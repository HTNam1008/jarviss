import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:jarvis/presentation/common/custome_header_bar.dart';
import 'package:jarvis/presentation/resources/color_manager.dart';
import 'package:jarvis/presentation/resources/values_manager.dart';

import '../../../domain/model/prompt.dart';
import '../main_prompt_view.dart';


class EditPromptView extends StatefulWidget {
  final Prompt prompt;
  const EditPromptView({required this.prompt, super.key});

  @override
  State<EditPromptView> createState() => _EditPromptViewState();
}

class _EditPromptViewState extends State<EditPromptView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _categoryController;
  late final TextEditingController _contentController;


  late bool _isPublic;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController(text: widget.prompt.content);
    _titleController = TextEditingController(text: widget.prompt.title);
    _descriptionController = TextEditingController(text: widget.prompt.description);
    _categoryController = TextEditingController(text: widget.prompt.category);
    _isPublic = widget.prompt.isPublic;
  }

  @override
  void dispose() {
    _contentController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  void _handleUpdate() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await GetIt.instance<PromptViewModel>().updatePrompt(
          widget.prompt.id,
          _titleController.text,
          _contentController.text,
          _descriptionController.text,
          _categoryController.text,
          _isPublic,
          'English'
      );

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Prompt updated successfully'))
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error updating prompt: $e'))
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
      child: Container(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Edit Prompt',
                style: TextStyle(
                  fontSize: AppSize.s20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSize.s20),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
              ),
              const SizedBox(height: AppSize.s16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
              ),
              const SizedBox(height: AppSize.s16),
              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(labelText: 'Content'),
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
              ),
              const SizedBox(height: AppSize.s16),
              TextFormField(
                controller: _categoryController,
                decoration: const InputDecoration(labelText: 'Category'),
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
              ),
              const SizedBox(height: AppSize.s16),
              SwitchListTile(
                title: const Text('Public'),
                value: _isPublic,
                onChanged: (bool value) {
                  setState(() => _isPublic = value);
                },
              ),
              const SizedBox(height: AppSize.s24),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: _isLoading ? null : () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        foregroundColor: ColorManager.teal,
                        padding: const EdgeInsets.symmetric(vertical: AppPadding.p12),
                        backgroundColor: ColorManager.teal.withOpacity(0.1),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: AppSize.s16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _handleUpdate,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.teal,
                        padding: const EdgeInsets.symmetric(vertical: AppPadding.p12),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator()
                          : const Text('Update'),
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
