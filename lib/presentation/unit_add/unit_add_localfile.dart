import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:jarvis/presentation/common/bottom_navigation.dart';
import 'package:jarvis/presentation/common/chat_input_box.dart';
import 'package:jarvis/presentation/common/custome_header_bar.dart';
import 'package:jarvis/presentation/resources/color_manager.dart';
import 'package:jarvis/presentation/resources/font_manager.dart';
import 'package:jarvis/presentation/resources/values_manager.dart';
import 'package:file_picker/file_picker.dart';
import 'package:jarvis/presentation/unit_add/unit_view_model.dart';
import '../common/dialog_util.dart';
import '../knowledge/knowledge_view.dart';

class UnitAddLocalfile extends StatefulWidget {
  final String knowledgeId;

  UnitAddLocalfile({super.key, required this.knowledgeId});

  @override
  State<UnitAddLocalfile> createState() => _UnitAddLocalfileState();
}

class _UnitAddLocalfileState extends State<UnitAddLocalfile> {
  PlatformFile? _selectedFile;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<void> _handleFileSelection() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['c','pdf', 'doc', 'docx', 'txt','cpp','java','html','json','md','php','pptx','rb','py','text'],
      );

      if (result != null) {
        setState(() {
          _selectedFile = result.files.first;
        });
      }
    } catch (e) {
      // Handle any errors that occurred during file picking
      debugPrint('Error picking file: $e');
    }
  }

  Future<void> _uploadLocalFile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    String? selectedFilePath = _selectedFile?.path;

    try {
      await GetIt.instance<UnitViewModel>().uploadLocalFile(
        widget.knowledgeId,
        selectedFilePath!,
      );

      Navigator.pop(context);
      showCustomDialog(
        context: context,
        type: DialogType.success,
        title: 'Success',
        message: 'Upload successfully',
      );
    } catch (e) {
      showCustomDialog(
        context: context,
        type: DialogType.error,
        title: 'Error',
        message: 'Failed to upload file: $e',
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
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
            const Row(
              children: [
                Expanded(
                  child: Text(
                    'Local file',
                    style: TextStyle(
                      fontSize: AppSize.s20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSize.s24),
            GestureDetector(
              onTap: _handleFileSelection,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(AppSize.s12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: AppSize.s60,
                      height: AppSize.s60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(AppSize.s12),
                        border: Border.all(
                          color: Colors.grey[300]!,
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        _selectedFile != null ? Icons.description : Icons.add,
                        size: AppSize.s32,
                        color: _selectedFile != null ? ColorManager.teal : Colors.grey[400],
                      ),
                    ),
                    const SizedBox(height: AppSize.s16),
                    Text(
                      _selectedFile?.name ?? 'Click here to upload file',
                      style: TextStyle(
                        fontSize: AppSize.s14,
                        color: Colors.grey[600],
                      ),
                    ),
                    if (_selectedFile != null) ...[
                      const SizedBox(height: AppSize.s8),
                      Text(
                        '${(_selectedFile!.size / 1024).toStringAsFixed(2)} KB',
                        style: TextStyle(
                          fontSize: AppSize.s12,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSize.s24),
            ElevatedButton(
              onPressed: _selectedFile != null
                  ? _uploadLocalFile
                  : null,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: AppPadding.p16),
                backgroundColor: ColorManager.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s12),
                ),
                disabledBackgroundColor: Colors.grey[300],
              ),
              child: _isLoading
                  ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
                  :const Text(
                'Connect',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: AppSize.s16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
