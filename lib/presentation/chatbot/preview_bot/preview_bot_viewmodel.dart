import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jarvis/domain/model/model.dart';
import 'package:jarvis/domain/usecase/ask_assistant_usecase.dart';
import 'package:jarvis/domain/usecase/retrieve_message_thread_usecase.dart';
import 'package:jarvis/presentation/base/baseviewmodel.dart';

class PreviewBotViewModel extends BaseViewModel implements PreviewBotViewModelInputs, PreviewBotViewModelOutputs {
  final AskAssistantUseCase _askAssistantUseCase;
  final RetrieveMessageThreadUseCase _retrieveMessageThreadUseCase;
  final List<MessageAssistant> _messages = [];

  final StreamController<List<MessageAssistant>> _messagesController = StreamController<List<MessageAssistant>>.broadcast();
  final StreamController<bool> _loadingController = StreamController<bool>.broadcast();

  PreviewBotViewModel(this._askAssistantUseCase, this._retrieveMessageThreadUseCase);


  @override
  Stream<List<MessageAssistant>> get outputMessages => _messagesController.stream;
  
  @override
  Stream<bool> get outputLoading => _loadingController.stream;


    Future<void> init(String threadId) async {
    if (threadId.isEmpty) return;
    
    _loadingController.add(true);
    
    final result = await _retrieveMessageThreadUseCase.execute(
      RetrieveMessageThreadUseCaseInput(openAiThreadId: threadId),
    );
    
    result.fold(
      (failure) => log(failure.message),
      (messages) {
        _messages.addAll(messages.data);
        _messagesController.add(_messages);
      },
    );
    
    _loadingController.add(false);
  }

  @override
  Future<void> sendMessage(String content, AssistantCustom assistant) async {
    if (content.isEmpty) return;

    _messages.add(MessageAssistant(message: content, isUser: true));
    _messagesController.add(_messages);
    _loadingController.add(true);

    final result = await _askAssistantUseCase.execute(
      AskAssistantUseCaseInput(
        assistandId: assistant.id,
        message: content,
        openAiThreadId: assistant.openAiThreadIdPlay ?? '',
        additionalInstruction: "",
      ),
    );

    result.fold(
      (failure) => print(failure.message),
      (response) {
        _messages.add(response);
        _messagesController.add(_messages);
      },
    );

    _loadingController.add(false);
  }

  @override
  void dispose() {
    _messagesController.close();
    _loadingController.close();
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

abstract class PreviewBotViewModelOutputs {
  Stream<List<MessageAssistant>> get outputMessages;
  Stream<bool> get outputLoading;
}

abstract class PreviewBotViewModelInputs {
  Future<void> sendMessage(String content, AssistantCustom assistant);
}
