// ignore_for_file: public_member_api_docs, sort_constructors_first
// lib/presentation/chat_view.dart

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:jarvis/app/constant.dart';
import 'package:jarvis/domain/model/model.dart';
import 'package:jarvis/presentation/chat/chat_viewmodel.dart';
import 'package:jarvis/presentation/common/chat_input_box.dart';
import 'package:jarvis/presentation/common/custome_header_bar.dart';
import 'package:jarvis/presentation/left_side_bar/app_drawer.dart';
import 'package:jarvis/presentation/resources/color_manager.dart';
import 'package:jarvis/presentation/resources/font_manager.dart';
import 'package:jarvis/presentation/resources/route_manager.dart';
import 'package:jarvis/presentation/resources/values_manager.dart';

class ChatView extends StatefulWidget {
  final String? conversationId;
  final String? assistantId;
  final String? assistantModel;

  const ChatView({
    super.key,
    this.conversationId,
    this.assistantId,
    this.assistantModel,
  });

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController _chatController = TextEditingController();
  late final ChatViewModel _viewModel;
  late final StreamSubscription<String?> _errorSubscription;
  late final ScrollController _scrollController;
  final getIt = GetIt.instance;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<String> assistantModels = [
    ConstantAssistantID.GPT_4_O,
    ConstantAssistantID.GPT_4_O_MINI,
    ConstantAssistantID.CLAUDE_3_HAIKU_20240307,
    ConstantAssistantID.CLAUDE_35_SONNET_20240229,
    ConstantAssistantID.GEMINI_15_FLASH_LATEST,
    ConstantAssistantID.GEMINI_15_PRO_LATEST,
  ];

  late String selectedModel;
  bool _isSending = false;
  bool isScrollBottom = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    selectedModel = assistantModels[1];
    _viewModel = getIt<ChatViewModel>();
    _viewModel.start();

    _errorSubscription = _viewModel.errorStream.listen((errorMessage) {
      if (errorMessage != null && errorMessage.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    });

    if (widget.conversationId != null /* && widget.assistantId != null && widget.assistantModel != null */) {
      _viewModel.loadConversationMessages(
        widget.conversationId!,
/*         widget.assistantId!,
        widget.assistantModel!, */
      );
    }

    _scrollController.addListener(_onScroll);

    /* WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    }); */
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 100,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels <=
        _scrollController.position.minScrollExtent) {
      if (_viewModel.hasMore && !_viewModel.isLoadingMore) {
        _fetchMoreConversations();
      }
    }
  }

  Future<void> _fetchMoreConversations() async {
    if (_viewModel.cursor == null) return;
    _viewModel.isLoadingMore = true;
    isScrollBottom = true;
    _viewModel.loadConversationMessages(widget.conversationId!);
  }

  @override
  void didUpdateWidget(covariant ChatView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _scrollToBottom();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _chatController.dispose();
    _errorSubscription.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      appBar: CustomHeaderBar(
              centerWidget: DropdownButton<String>(
              value: selectedModel,
              dropdownColor: ColorManager.teal,
              style: TextStyle(color: ColorManager.white),
              underline: const SizedBox(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedModel = newValue;
                  });
                }
              },
              items: assistantModels.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            leading: IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
            ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(Routes.upgradeProRoute);
                    },
                    child: Text(
                      "Upgrade",
                      style: TextStyle(color: Colors.blue.shade100, fontSize: AppSize.s16),
                    )),
                StreamBuilder<int>(
                  stream: _viewModel.remainingUsageStream,
                  builder: (context, snapshot) {
                    int remainingUsage = snapshot.data ?? 50;
                    return Container(
                      margin: const EdgeInsets.only(right: AppSize.s8),
                      padding: const EdgeInsets.symmetric(horizontal: AppSize.s12, vertical: AppSize.s6),
                      decoration: BoxDecoration(
                        color: Colors.teal[400],
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        children: [
                          Text('$remainingUsage', style: TextStyle(color: ColorManager.white, fontSize: AppSize.s16)),
                          const SizedBox(width: AppSize.s4),
                          Icon(Icons.star, color: ColorManager.white, size: AppSize.s16),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<Message>>(
                stream: _viewModel.messagesStream,
                builder: (context, snapshot) {
                  if (widget.conversationId == null ) {
                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      isScrollBottom = true;
                      return _buildChatMessages(snapshot.data!);
                    } else {
                      return _buildInitialContent();
                    }
                  } else {
                    if (snapshot.connectionState == ConnectionState.waiting && _viewModel.messages.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    else {
                      return _buildChatMessages(_viewModel.messages);
                    } 
                  }
                },
              ),
            ),
            ChatInputBox(
              controller: _chatController,
              onSend: _sendMessage,
              isSending: _isSending,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInitialContent() {
    return Container(
      color: Colors.teal.shade50,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSize.s16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hi, good afternoon!',
              style: TextStyle(
                  fontSize: AppSize.s24,
                  fontWeight: FontWeightManager.bold),
            ),
            const SizedBox(height: AppSize.s8),
            Text(
              'I\'m a chatbot.',
              style: TextStyle(
                  fontSize: AppSize.s16, color: ColorManager.grey),
            ),
            const SizedBox(height: AppSize.s20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildUploadButton(
                  icon: Icons.image,
                  label: 'Upload your image',
                  color: Colors.teal.shade100,
                ),
                _buildUploadButton(
                  icon: Icons.folder,
                  label: 'Upload your file',
                  color: Colors.blue.shade100,
                ),
              ],
            ),
            const SizedBox(height: AppSize.s20),
            const Text('You can ask me like this',
                style: TextStyle(fontSize: AppSize.s18)),
            const SizedBox(height: AppSize.s10),
            ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                _buildSuggestion('Write an email', 'to submission project'),
                _buildSuggestion('Suggest events', 'for this summer'),
                _buildSuggestion('List some books',
                    'related to adventure'),
                _buildSuggestion('Explain an issue',
                    'why the earth is round'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatMessages(List<Message> messages) {
    if (isScrollBottom) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
        isScrollBottom = false;
      });
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(AppSize.s16),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        return Align(
          alignment:
              message.isUser ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.all(AppSize.s12),
            margin: const EdgeInsets.symmetric(vertical: AppSize.s4),
            decoration: BoxDecoration(
              color: message.isUser
                  ? ColorManager.primary
                  : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(AppSize.s8),
            ),
            child: Column(
              crossAxisAlignment: message.isUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Text(
                  message.message,
                  style: TextStyle(
                    color: message.isUser ? Colors.white : Colors.black,
                    fontSize: AppSize.s16,
                  ),
                ),
                const SizedBox(height: AppSize.s4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!message.isUser)
                      const CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.blue,
                        child: Icon(
                          Icons.person,
                          size: 12,
                          color: Colors.white,
                        ),
                      ),
                    if (!message.isUser) const SizedBox(width: 4),
                    message.timestamp !=null ? Text(
                      '${message.timestamp!.hour}:${message.timestamp!.minute.toString().padLeft(2, '0')}',
                      style: TextStyle(
                        color: message.isUser
                            ? Colors.white70
                            : Colors.black54,
                        fontSize: AppSize.s12,
                      ),
                    ) : const SizedBox.shrink(),
                    // const SizedBox(width: 4),
                    // Text(
                    //   'Usage: ${message.remainingUsage}',
                    //   style: TextStyle(
                    //     color: message.isUser
                    //         ? Colors.white70
                    //         : Colors.black54,
                    //     fontSize: AppSize.s12,
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _sendMessage() async {
    String message = _chatController.text.trim();
    if (message.isNotEmpty) {
      _chatController.clear();
      setState(() {
        _isSending = true; 
      });

      await _viewModel.sendMessage(message, selectedModel, conversationId:  widget.conversationId);

      setState(() {
        _isSending = false;
      });

    }
  }

  Widget _buildUploadButton({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return GestureDetector(
      onTap: () {
        // Logic khi nhấn nút upload
      },
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(AppSize.s16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: AppSize.s40),
            const SizedBox(height: AppSize.s8),
            Text(label),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestion(String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppSize.s6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSize.s10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        tileColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s10),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: AppSize.s16),
        onTap: () {
          // Khi người dùng nhấn vào gợi ý, tự động gửi tin nhắn
          _chatController.text = "$title, $subtitle";
          _sendMessage();
        },
      ),
    );
  }
}
