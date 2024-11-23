// lib/presentation/viewmodel/chat_viewmodel.dart

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jarvis/app/constant.dart';
import 'package:jarvis/app/functions.dart';
import 'package:jarvis/data/request/ai_chat/send_message/assistant.dart';
import 'package:jarvis/data/request/ai_chat/send_message/chat_conversation.dart';
import 'package:jarvis/data/request/ai_chat/send_message/chat_message.dart';
import 'package:jarvis/data/request/ai_chat/send_message/message_role.dart';
import 'package:jarvis/data/request/ai_chat/send_message/send_message_metadata.dart';
import 'package:jarvis/domain/model/model.dart';
import 'package:jarvis/domain/usecase/base_usecase.dart';
import 'package:jarvis/domain/usecase/send_message_usecase.dart';
import 'package:jarvis/domain/usecase/usage_token_usecase.dart';
import 'package:jarvis/presentation/base/baseviewmodel.dart';

class ChatViewModel extends BaseViewModel
    implements ChatViewModelInputs, ChatViewModelOutputs {
  final SendMessageUseCase _sendMessageUseCase;
  final UsageTokenUseCase _usageTokenUseCase;

  final StreamController<List<Message>> _messagesStreamController =
      StreamController<List<Message>>.broadcast();

  final StreamController<String?> _errorStreamController =
      StreamController<String?>.broadcast();

  final StreamController<int> _remainingUsageStreamController =
      StreamController<int>.broadcast();

  final List<Message> _messages = [];

  String? _conversationId;

  int _remainingUsage = 50;

  ChatViewModel(this._sendMessageUseCase, this._usageTokenUseCase);

  // Inputs
  @override
  void sendMessage(String content, String assistantName) async {
    if (content.isEmpty) return;

    // Tạo danh sách ConversationMessage từ _messages
    final conversationMessages = _messages.map((msg) {
      Assistant assistant;
      if (msg.assistant != null) {
        assistant = Assistant(
          id: msg.assistant!.id,
          model: msg.assistant!.model,
          name: msg.assistant!.name,
        );
      } else {
        assistant = Assistant(id: "gpt-4o", model: "Dify", name: "GPT-4o");
      }
      return ChatMessage(
        role: msg.isUser ? MessageRole.user : MessageRole.model,
        content: msg.message,
        assistant: assistant,
      );
    }).toList();

    // Tạo metadata
    final metadata = SendMessageMetadata(
      conversation: _conversationId != null
          ? ChatConversation(
              id: _conversationId,
              messages: conversationMessages,
            )
          : ChatConversation(
              messages: [], // Tin nhắn đầu tiên, danh sách rỗng
            ),
    );

    // Tạo input cho use case
    final assistant = Assistant(
      id: getModelId(assistantName),
      model: ConstantAssistantModel.DIFY,
      name: getModelName(assistantName),
    );
    
    final input = SendMessageUseCaseInput(
      content: content,
      metadata: metadata,
      assistant: assistant,
    );
    print("input: ${jsonEncode(input.toJson())}");
    // Tạo tin nhắn của người dùng
    final userMessage = Message(
      message: content,
      isUser: true,
      conversationId: _conversationId ?? '',
      remainingUsage: 0,
      assistant: assistant,
    );


    _messages.add(userMessage);
    _messagesStreamController.add(List.from(_messages));

    final result = await _sendMessageUseCase.execute(input);

    result.fold(
      (failure) {
        print(failure);
        _errorStreamController.add(failure.message);
      },
      (responseMessage) {
        print('receive message success');
        _conversationId ??= responseMessage.conversationId;

        final assistantMessage = responseMessage;
        _messages.add(assistantMessage);
        _messagesStreamController.add(List.from(_messages)); // Cập nhật stream

        _remainingUsage = assistantMessage.remainingUsage;
        _remainingUsageStreamController.add(_remainingUsage);
      },
    );
  }

  @override
  Future<void> getUsageToken() async {
    final result = await _usageTokenUseCase.execute(NoParams());
    result.fold(
      (failure) {
        print(failure);
        _errorStreamController.add(failure.message);
      },
      (responseMessage) {
        print('get usage token success');

        final assistantMessage = responseMessage;
        _remainingUsage = assistantMessage.availaleTokens;
        _remainingUsageStreamController.add(_remainingUsage);
      },
    );
  }

  // Outputs
  @override
  Stream<List<Message>> get messagesStream => _messagesStreamController.stream;

  @override
  Stream<String?> get errorStream => _errorStreamController.stream;

  @override
  Stream<int> get remainingUsageStream =>
      _remainingUsageStreamController.stream;

  @override
  void start() async {
    await getUsageToken();
  }

  @override
  void dispose() {
    _messagesStreamController.close();
    _errorStreamController.close();
    _remainingUsageStreamController.close();
    super.dispose();
  }

  @override
  Future<void> navigateNamed(BuildContext context, String route) {
    // TODO: implement navigateNamed
    throw UnimplementedError();
  }

  @override
  Future<void> navigateReplaceNamed(BuildContext context, String route) {
    // TODO: implement navigateReplaceNamed
    throw UnimplementedError();
  }
}

abstract class ChatViewModelInputs {
  void sendMessage(String content, String selectedModel);
  void getUsageToken();
  // Sink để gửi các sự kiện nếu cần
}

abstract class ChatViewModelOutputs {
  Stream<List<Message>> get messagesStream;
  Stream<String?> get errorStream;
  Stream<int> get remainingUsageStream;
}
