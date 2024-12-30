import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:jarvis/data/request/ai_bot/delete_assistant_request.dart';
import 'package:jarvis/data/responses/ai_bot/get_assistants_response.dart';
import 'package:jarvis/domain/model/model.dart';
import 'package:jarvis/domain/usecase/delete_assistant_usecase.dart';
import 'package:jarvis/domain/usecase/get_assistants_usecase.dart';
import 'package:jarvis/presentation/base/baseviewmodel.dart';

class MainChatbotViewModel extends BaseViewModel 
    implements MainChatbotViewModelInputs, MainChatbotViewModelOutputs {
  
  final GetAssistantsUseCase _getAssistantsUseCase;
  final DeleteAssistantUseCase _deleteAssistantUseCase;
  List<AssistantCustom>? _cachedAssistants;
  bool _isInitialized = false;

  final StreamController<List<AssistantCustom>> _assistantsController = 
      StreamController<List<AssistantCustom>>.broadcast();
  final StreamController<bool> _isLoadingController = 
      StreamController<bool>.broadcast();
  final StreamController<String> _errorController = 
      StreamController<String>.broadcast();

  MainChatbotViewModel(this._getAssistantsUseCase, this._deleteAssistantUseCase);

  @override
  void start() {
    if (!_isInitialized) {
      getAssistants();
      _isInitialized = true;
    } else if (_cachedAssistants != null && !_assistantsController.isClosed) {
      inputAssistants.add(_cachedAssistants!);
    }
  }

  void refreshAssistants() {
    _isInitialized = false;
    start();
  }

  void updateCachedAssistants(List<AssistantCustom> assistants) {
    _cachedAssistants = assistants;
  }

  @override
  void dispose() {
    _assistantsController.close();
    _isLoadingController.close();
    _errorController.close();
    super.dispose();
  }

  @override
  Future<void> getAssistants({
    bool? isFavorite,
    String? searchQuery,
    double limit = 20,
    double offset = 0,
  }) async {
    if (!_isLoadingController.isClosed) {
      inputIsLoading.add(true);
    }
    
    final result = await _getAssistantsUseCase.execute(
      GetAssistantsUseCaseInput(
        isFavorite: isFavorite,
        limit: limit,
        offset: offset,
        q: searchQuery,
      ),
    );

    log("Get assistants success 1");

    result.fold(
      (failure) {
        log(failure.message);
        if (!_errorController.isClosed) {
          inputError.add(failure.message);
        }
        if (_cachedAssistants != null && !_assistantsController.isClosed) {
          inputAssistants.add(_cachedAssistants!);
        }
      },
      (response) {
        log("Get assistants success 2");
        _cachedAssistants = response.data;
         if (!_assistantsController.isClosed) {
          inputAssistants.add(response.data);
        }
      },
    );

    if (!_isLoadingController.isClosed) {
      inputIsLoading.add(false);
    }
  }

  @override
  Future<bool> deleteAssistant(String assistantId) async {
    inputIsLoading.add(true);
    
    final result = await _deleteAssistantUseCase.execute(
      DeleteAssistantRequest(assistantId: assistantId),
    );
    
    final success = result.fold(
      (failure) {
        inputError.add(failure.message);
        return false;
      },
      (response) => true,
    );
    
    inputIsLoading.add(false);
    return success;
  }

  @override
  Sink<List<AssistantCustom>> get inputAssistants => _assistantsController.sink;

  @override
  Sink<bool> get inputIsLoading => _isLoadingController.sink;

  @override
  Sink<String> get inputError => _errorController.sink;

  @override
  Stream<List<AssistantCustom>> get outputAssistants => _assistantsController.stream;

  @override
  Stream<bool> get outputIsLoading => _isLoadingController.stream;

  @override
  Stream<String> get outputError => _errorController.stream;

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

abstract class MainChatbotViewModelInputs {
  Future<void> getAssistants({bool? isFavorite, String? searchQuery});
  Future<bool> deleteAssistant(String assistantId);
  Sink<List<AssistantCustom>> get inputAssistants;
  Sink<bool> get inputIsLoading;
  Sink<String> get inputError;
}

abstract class MainChatbotViewModelOutputs {
  Stream<List<AssistantCustom>> get outputAssistants;
  Stream<bool> get outputIsLoading;
  Stream<String> get outputError;
}