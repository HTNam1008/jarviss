import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:jarvis/presentation/resources/color_manager.dart';
import 'package:jarvis/presentation/resources/values_manager.dart';
import 'package:jarvis/presentation/unit_add/unit_view_model.dart';

import '../common/dialog_util.dart';

class UnitAddSlack extends StatefulWidget {
  final String knowledgeId;

  UnitAddSlack({super.key, required this.knowledgeId});

  @override
  State<UnitAddSlack> createState() => _UnitAddSlackState();
}

class _UnitAddSlackState extends State<UnitAddSlack> {
  final TextEditingController _workspaceController = TextEditingController();
  final TextEditingController _tokenController = TextEditingController();
  final TextEditingController _labelController = TextEditingController();
  String? _urlErrorText;
  String? _labelErrorText;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _workspaceController.dispose();
    _tokenController.dispose();
    _labelController.dispose();
    super.dispose();
  }

  Future<void> _uploadSlackFile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {;
    await GetIt.instance<UnitViewModel>().uploadSlackFile(
      widget.knowledgeId,
      _labelController.text,
      _workspaceController.text,
      _tokenController.text,
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
        width: 900,
        child: Form(
         key: _formKey,
          child: SingleChildScrollView(
            child: Column(
             mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
             const Row(
              children: [
                Expanded(
                  child: Text(
                    'Slack',
                    style: TextStyle(
                      fontSize: AppSize.s20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSize.s24),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(AppSize.s12),
              ),
              child: Column(
                children: [
                  const SizedBox(height: AppSize.s16),
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
                      Icons.language,
                      size: AppSize.s32,
                      color: Colors.grey[400],
                    ),
                  ),
                  const SizedBox(height: AppSize.s16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                    child: Column(
                      children: [
                        TextField(
                          controller: _labelController,
                          decoration: InputDecoration(
                            hintText: 'Enter label',
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                            ),
                            errorText: _labelErrorText,
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppSize.s12),
                              borderSide: BorderSide.none,
                            ),
                            prefixIcon: Icon(
                              Icons.label_outline,
                              color: Colors.grey[400],
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: AppPadding.p16,
                              vertical: AppPadding.p12,
                            ),
                          ),
                          onChanged: (value) {
                            if (_labelErrorText != null) {
                              setState(() {
                                _labelErrorText = null;
                              });
                            }
                          },
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: AppSize.s12),
                        TextField(
                          controller: _workspaceController,
                          decoration: InputDecoration(
                            hintText: 'Enter slack workspace',
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                            ),
                            errorText: _urlErrorText,
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppSize.s12),
                              borderSide: BorderSide.none,
                            ),
                            prefixIcon: Icon(
                              Icons.link,
                              color: Colors.grey[400],
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: AppPadding.p16,
                              vertical: AppPadding.p12,
                            ),
                          ),
                          onChanged: (value) {
                            if (_urlErrorText != null) {
                              setState(() {
                                _urlErrorText = null;
                              });
                            }
                          },
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) => _uploadSlackFile,
                        ),
                        const SizedBox(height: AppSize.s12),
                        TextField(
                          controller: _tokenController,
                          decoration: InputDecoration(
                            hintText: 'Enter slack bot token',
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                            ),
                            errorText: _urlErrorText,
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppSize.s12),
                              borderSide: BorderSide.none,
                            ),
                            prefixIcon: Icon(
                              Icons.link,
                              color: Colors.grey[400],
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: AppPadding.p16,
                              vertical: AppPadding.p12,
                            ),
                          ),
                          onChanged: (value) {
                            if (_urlErrorText != null) {
                              setState(() {
                                _urlErrorText = null;
                              });
                            }
                          },
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) => _uploadSlackFile,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSize.s16),
                ],
              ),
            ),
            const SizedBox(height: AppSize.s24),
            ElevatedButton(
              onPressed: _isLoading ? null : _uploadSlackFile,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: AppPadding.p16),
                backgroundColor: ColorManager.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s12),
                ),
                disabledBackgroundColor: Colors.grey[300],
              ),
              child:  _isLoading
                  ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
                  : const Text(
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
     ),
    );
  }
}
