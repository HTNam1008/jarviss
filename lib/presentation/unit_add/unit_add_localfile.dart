import 'package:flutter/material.dart';
import 'package:jarvis/presentation/common/bottom_navigation.dart';
import 'package:jarvis/presentation/common/chat_input_box.dart';
import 'package:jarvis/presentation/common/custome_header_bar.dart';
import 'package:jarvis/presentation/resources/color_manager.dart';
import 'package:jarvis/presentation/resources/font_manager.dart';
import 'package:jarvis/presentation/resources/values_manager.dart';
import 'package:file_picker/file_picker.dart';

class UnitAddLocalfile extends StatefulWidget {
  @override
  State<UnitAddLocalfile> createState() => _UnitAddLocalfileState();
}

class _UnitAddLocalfileState extends State<UnitAddLocalfile> {
  PlatformFile? _selectedFile;

  Future<void> _handleFileSelection() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'txt'],
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
                        color: _selectedFile != null ? Colors.purple : Colors.grey[400],
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
                  ? () {
                Navigator.pop(context, _selectedFile);
              }
                  : null,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: AppPadding.p16),
                backgroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s12),
                ),
                disabledBackgroundColor: Colors.grey[300],
              ),
              child: const Text(
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
    );
  }
}
