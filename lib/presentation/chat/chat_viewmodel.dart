// lib/presentation/viewmodel/chat_viewmodel.dart

import 'dart:async';
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
import 'package:jarvis/domain/usecase/get_conversation_history_usecase.dart';
import 'package:jarvis/domain/usecase/send_message_usecase.dart';
import 'package:jarvis/domain/usecase/usage_token_usecase.dart';
import 'package:jarvis/presentation/base/baseviewmodel.dart';

class ChatViewModel extends BaseViewModel
    implements ChatViewModelInputs, ChatViewModelOutputs {
  final SendMessageUseCase _sendMessageUseCase;
  final UsageTokenUseCase _usageTokenUseCase;
  final GetConversationHistoryUsecase _getConversationHistoryUsecase;

  final StreamController<List<Message>> _messagesStreamController =
      StreamController<List<Message>>.broadcast();

  final StreamController<String?> _errorStreamController =
      StreamController<String?>.broadcast();

  final StreamController<int> _remainingUsageStreamController =
      StreamController<int>.broadcast();

  final List<Message> _messages = [];
  List<Message> get messages => _messages;

  String? _conversationId;

  String? _cursor;
  String? get cursor => _cursor;

  bool _hasMore = false;
  bool get hasMore => _hasMore;

  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;

  set isLoadingMore(bool value) {
    _isLoadingMore = value;
  }

  int _remainingUsage = 50;

  ChatViewModel(this._sendMessageUseCase, this._usageTokenUseCase, this._getConversationHistoryUsecase);

  // Inputs
  @override
  Future<void> sendMessage(String content, String assistantName, {String? conversationId}) async {
    if (content.isEmpty) return;

    if (conversationId != null) _conversationId = conversationId;

    final conversationMessages = _messages.map((msg) {
      Assistant assistant;
      if (msg.assistant != null) {
        assistant = Assistant(
          id: msg.assistant!.id,
          model: msg.assistant!.model,
          name: msg.assistant!.name,
        );
      } else {
        assistant = Assistant(id: "gpt-4o", model: "dify", name: "GPT-4o");
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
              messages: [],
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
    // print("input: ${jsonEncode(input.toJson())}");

    final userMessage = Message(
      message: content,
      isUser: true,
      conversationId: _conversationId ?? '',
      remainingUsage: 0,
      assistant: assistant,
      timestamp: DateTime.now(),
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

  @override
  Future<void> loadConversationMessages(
      String conversationId, {String? assistantId, String? assistantModel}) async {
    final input = GetConversationHistoryUsecaseInput(
      conversationId: conversationId,
      assistantId: assistantId,
      assistantModel: assistantModel,
      cursor: _hasMore ? _cursor : null,
    );
    final result = await _getConversationHistoryUsecase.execute(input);

    result.fold(
      (failure) {
        _errorStreamController.add(failure.message);
        isLoadingMore = false;
      },
      (responseMessage) {
        _cursor = responseMessage.cursor;
        if (responseMessage.items != null) {
          if (!_hasMore) {
            _messages.clear();
          }
          _messages.insertAll(0,responseMessage.items!);
        }
        _hasMore = responseMessage.has_more;

        _messagesStreamController.add(List.from(_messages));
        isLoadingMore = false;
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
  void loadConversationMessages(String conversationId, {String? assistantId, String? assistantModel});
  // Sink để gửi các sự kiện nếu cần
}

abstract class ChatViewModelOutputs {
  Stream<List<Message>> get messagesStream;
  Stream<String?> get errorStream;
  Stream<int> get remainingUsageStream;
}
