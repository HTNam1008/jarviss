import 'package:flutter/material.dart';
import 'package:jarvis/presentation/common/bottom_navigation.dart';
import 'package:jarvis/presentation/common/chat_input_box.dart';
import 'package:jarvis/presentation/common/custome_header_bar.dart';
import 'package:jarvis/presentation/resources/color_manager.dart';
import 'package:jarvis/presentation/resources/font_manager.dart';
import 'package:jarvis/presentation/resources/values_manager.dart';
import 'package:file_picker/file_picker.dart';

class UnitAddConfluence extends StatefulWidget {
  @override
  State<UnitAddConfluence> createState() => _UnitAddConfluenceState();
}

class _UnitAddConfluenceState extends State<UnitAddConfluence> {
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _labelController = TextEditingController();
  String? _urlErrorText;
  String? _labelErrorText;
  bool _isLoading = false;

  @override
  void dispose() {
    _urlController.dispose();
    _labelController.dispose();
    super.dispose();
  }

  bool _isValidUrl(String url) {
    Uri? uri = Uri.tryParse(url);
    return uri != null &&
        (uri.scheme == 'http' || uri.scheme == 'https') &&
        uri.host.isNotEmpty;
  }

  Future<void> _handleConnect() async {
    final url = _urlController.text.trim();
    final label = _labelController.text.trim();
    bool hasError = false;

    if (url.isEmpty) {
      setState(() {
        _urlErrorText = 'Please enter a URL';
      });
      hasError = true;
    } else if (!_isValidUrl(url)) {
      setState(() {
        _urlErrorText = 'Please enter a valid URL';
      });
      hasError = true;
    }

    if (label.isEmpty) {
      setState(() {
        _labelErrorText = 'Please enter a label';
      });
      hasError = true;
    }

    if (hasError) return;

    setState(() {
      _isLoading = true;
      _urlErrorText = null;
      _labelErrorText = null;
    });

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        Navigator.pop(context, {
          'url': url,
          'label': label,
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _urlErrorText = 'Failed to connect to website';
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Row(
              children: [
                Expanded(
                  child: Text(
                    'Confluence',
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
                          controller: _urlController,
                          decoration: InputDecoration(
                            hintText: 'Enter website URL',
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
                          onSubmitted: (_) => _handleConnect(),
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
              onPressed: _isLoading ? null : _handleConnect,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: AppPadding.p16),
                backgroundColor: ColorManager.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s12),
                ),
                disabledBackgroundColor: Colors.grey[300],
              ),
              child: _isLoading
                  ? SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
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
    );
  }
}
