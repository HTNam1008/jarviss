import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:jarvis/presentation/knowledge/knowledge_view.dart';
import 'package:jarvis/presentation/resources/color_manager.dart';
import 'package:jarvis/presentation/resources/values_manager.dart';
import '../../common/dialog_util.dart';
import '../../prompt/main_prompt_view.dart';

class CreateKnowledgeView extends StatefulWidget {
  const CreateKnowledgeView({super.key});

  @override
  State<CreateKnowledgeView> createState() => _CreateKnowledgeViewState();
}

class _CreateKnowledgeViewState extends State<CreateKnowledgeView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _createKnowledge() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await GetIt.instance<KnowledgeViewModel>().createKnowledge(
          _nameController.text,
          _descriptionController.text,
      );

      Navigator.pop(context);
      showCustomDialog(
        context: context,
        type: DialogType.success,
        title: 'Success',
        message: 'Knowledge created successfully',
      );
    } catch (e) {
      showCustomDialog(
        context: context,
        type: DialogType.error,
        title: 'Error',
        message: 'Failed to create knowledge: $e',
      );
    } finally {
      setState(() => _isLoading = false);
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
        width: 700,
        child: Form(
          key: _formKey,
            child: SingleChildScrollView(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Create knowledge',
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
                      onPressed:  _isLoading ? null : () {
                        Navigator.of(context).pop();
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
                      onPressed: _isLoading ? null : _createKnowledge,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: AppPadding.p12),
                        backgroundColor: ColorManager.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSize.s12),
                        ),
                      ),
                      child:
                      _isLoading
                          ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                          : const Text('Create'),
                    ),
                  ),
                ],
              ),
            ],
          ),
            ),
        )
      ),
    );
  }
}
