import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:jarvis/presentation/resources/color_manager.dart';
import 'package:jarvis/presentation/resources/strings_manager.dart';
import 'package:jarvis/presentation/resources/values_manager.dart';

import '../../domain/model/prompt.dart';
import '../prompt/main_prompt_view.dart';
import '../resources/route_manager.dart';

class ChatInputBox extends StatefulWidget  {
  final TextEditingController controller;
  final VoidCallback onSend;

  ChatInputBox({
    required this.controller,
    required this.onSend,
  });

  @override
  State<ChatInputBox> createState() => _ChatInputBoxState();

}

class _ChatInputBoxState extends State<ChatInputBox> {
  final FocusNode _focusNode = FocusNode();
  bool _showSuggestions = false;
  final PromptViewModel _promptViewModel = GetIt.instance<PromptViewModel>();
  List<Prompt> _promptSuggestions = [];
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _hasShownOverlay = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _removeOverlay();
    super.dispose();
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus && !_hasShownOverlay) {
      _fetchPromptSuggestions();
      _hasShownOverlay = true;
    }
  }

  void _fetchPromptSuggestions() async {
    try {
      await _promptViewModel.getPrompts("Marketing");

      // Safely get first 3 prompts
      if (mounted) {
        setState(() {
          final allPrompts = _promptViewModel.prompts;
          final endIndex = allPrompts.length > 3 ? 3 : allPrompts.length;
          _promptSuggestions = allPrompts.sublist(0, endIndex);

          // Only show overlay if we have suggestions
          if (_promptSuggestions.isNotEmpty) {
            _showOverlay();
          }
        });
      }
    } catch (e) {
      print('Error fetching prompts: $e');
    }
  }

  void _showOverlay() {
    _removeOverlay();

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: MediaQuery.of(context).size.width - 32,
        bottom: MediaQuery.of(context).viewInsets.bottom + 80,
        left: 16,
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(AppSize.s8),
          child: Container(
            constraints: const BoxConstraints(
              maxHeight: 200,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppSize.s8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Suggested prompts',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              _removeOverlay();
                              Navigator.pushNamed(context, Routes.promptRoute);
                            },
                            child: Text(
                              'View all',
                              style: TextStyle(
                                color: ColorManager.teal,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          InkWell(
                            onTap: _removeOverlay,
                            child: Icon(
                              Icons.close,
                              size: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                ..._promptSuggestions.map((prompt) =>
                    InkWell(
                      onTap: () {
                        widget.controller.text = prompt.content;
                        _removeOverlay();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey.shade200,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.north,
                              color: ColorManager.teal,
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                prompt.title,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ).toList(),
              ],
            ),
          ),
        ),
      ),
    );

    if (mounted && context.mounted) {
      Overlay.of(context)?.insert(_overlayEntry!);
    }
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.s8, vertical: AppSize.s10),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        //borderRadius: BorderRadius.all(Radius.circular(AppSize.s16)),
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: () {
              // Logic khi nhấn nút thêm
            },
          ),
          Expanded(
            child: TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              decoration: InputDecoration(
                hintText: AppStrings.chatHintText,

                // border: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(AppSize.s100),
                //   borderSide: BorderSide(color: Colors.blue),
                // ),
                // filled: true,
                // fillColor: ColorManager.white,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: ColorManager.teal),
            onPressed: widget.onSend,
          ),
        ],
      ),
    ),
    );
  }
}
