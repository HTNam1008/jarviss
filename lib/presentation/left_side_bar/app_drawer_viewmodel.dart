// app_drawer_viewmodel.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jarvis/data/request/ai_chat/send_message/assistant.dart';
import 'package:jarvis/data/responses/ai_chat/get_conversations_response.dart';
import 'package:jarvis/domain/model/model.dart';
import 'package:jarvis/domain/usecase/get_conversations_usecase.dart';
import 'package:jarvis/presentation/base/baseviewmodel.dart';

class AppDrawerViewModel extends BaseViewModel implements AppDrawerViewModelInputs, AppDrawerViewModelOutputs {
  final GetConversationsUsecase _getConversationsUsecase;
  AppDrawerViewModel(this._getConversationsUsecase);

  final StreamController<Conversations> _conversationsStreamController =
      StreamController<Conversations>.broadcast();

  final StreamController<String?> _errorStreamController =
      StreamController<String?>.broadcast();

  final List<ItemConversation> _chatHistory = [];

  List<ItemConversation> get chatHistory => _chatHistory;

  String? _cursor;
  bool _hasMore = true;
  bool _isLoadingMore = false;

  String? get cursor => _cursor;

  bool get hasMore => _hasMore;

  bool get isLoadingMore => _isLoadingMore;
  set isLoadingMore(bool value) {
    _isLoadingMore = value;
  }

  @override
  Future<void> navigateNamed(BuildContext context, String route) {
    throw UnimplementedError();
  }

  @override
  Future<void> navigateReplaceNamed(BuildContext context, String route) async{
    await Navigator.pushReplacementNamed(context, route);
  }

  // inputs
  @override
  void getConversations({Assistant? assistant}) async {
    // if (!_isLoadingMore) return; 
    final GetConversationsUsecaseInput input = GetConversationsUsecaseInput(assistant: assistant, cursor: _hasMore ? cursor : null);
    final result = await _getConversationsUsecase.execute(input);

    result.fold(
      (failure) {
        _errorStreamController.add(failure.message);
        isLoadingMore = false;
      },
      (responseMessage) {
        _cursor = responseMessage.cursor;
        if (responseMessage.items != null) {
          if (!_hasMore) {
            _chatHistory.clear();
          }
          _chatHistory.addAll(responseMessage.items!);
        }
        _hasMore = responseMessage.has_more;
        _conversationsStreamController.add(responseMessage);
        isLoadingMore = false;
      },
    );
  }

  //outputs
  @override
  Stream<Conversations> get conversationsStream => _conversationsStreamController.stream;

  @override
  Stream<String?> get errorStream => _errorStreamController.stream;

  @override
  void dispose() {
    _conversationsStreamController.close();
    _errorStreamController.close();
    super.dispose();
  }
}

abstract class AppDrawerViewModelInputs {
  void getConversations({Assistant? assistant});
}

abstract class AppDrawerViewModelOutputs {
  Stream<Conversations> get conversationsStream;
  Stream<String?> get errorStream;
}
