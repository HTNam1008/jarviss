import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jarvis/data/responses/ai_bot/get_assistants_response.dart';
import 'package:jarvis/domain/usecase/get_assistants_usecase.dart';
import 'package:jarvis/presentation/base/baseviewmodel.dart';

class MainChatbotViewModel extends BaseViewModel 
    implements MainChatbotViewModelInputs, MainChatbotViewModelOutputs {
  
  final GetAssistantsUseCase _getAssistantsUseCase;
  
  final StreamController<List<AssistantData>> _assistantsController = 
      StreamController<List<AssistantData>>.broadcast();
  final StreamController<bool> _isLoadingController = 
      StreamController<bool>.broadcast();
  final StreamController<String> _errorController = 
      StreamController<String>.broadcast();

  MainChatbotViewModel(this._getAssistantsUseCase);

  @override
  void start() {
    getAssistants();
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
    inputIsLoading.add(true);
    
    final result = await _getAssistantsUseCase.execute(
      GetAssistantsUseCaseInput(
        isFavorite: isFavorite,
        limit: limit,
        offset: offset,
        q: searchQuery,
      ),
    );

    print("Get assistants success 1");

    result.fold(
      (failure) {
        print(failure.message);
        inputError.add(failure.message);
      },
      (response) {
        print("Get assistants success 2");
        inputAssistants.add(response.data);
      },
    );

    inputIsLoading.add(false);
  }

  @override
  Sink<List<AssistantData>> get inputAssistants => _assistantsController.sink;

  @override
  Sink<bool> get inputIsLoading => _isLoadingController.sink;

  @override
  Sink<String> get inputError => _errorController.sink;

  @override
  Stream<List<AssistantData>> get outputAssistants => _assistantsController.stream;

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
  Sink<List<AssistantData>> get inputAssistants;
  Sink<bool> get inputIsLoading;
  Sink<String> get inputError;
}

abstract class MainChatbotViewModelOutputs {
  Stream<List<AssistantData>> get outputAssistants;
  Stream<bool> get outputIsLoading;
  Stream<String> get outputError;
}