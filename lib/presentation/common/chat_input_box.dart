import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:jarvis/presentation/resources/color_manager.dart';
import 'package:jarvis/presentation/resources/strings_manager.dart';
import 'package:jarvis/presentation/resources/values_manager.dart';

import '../../domain/model/prompt.dart';
import '../prompt/main_prompt_view.dart';

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
        bottom: MediaQuery.of(context).viewInsets.bottom + 80, // Position above keyboard and input
        left: 16, // Add horizontal padding
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(AppSize.s8),
            child: Container(
              constraints: BoxConstraints(
                maxHeight: 200, // Limit maximum height
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppSize.s8),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: _promptSuggestions.map((prompt) =>
                    ListTile(
                      leading: Icon(
                        Icons.arrow_upward,
                        color: ColorManager.teal,
                        size: AppSize.s16,
                      ),
                      title: Text(
                        prompt.title,
                        style: const TextStyle(fontSize: 14),
                      ),
                      onTap: () {
                        widget.controller.text = prompt.content;
                        _removeOverlay();
                        _focusNode.unfocus();
                      },
                    ),
                ).toList(),
              ),
            ),
        ),
      ),
    );

    Overlay.of(context)?.insert(_overlayEntry!);
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
