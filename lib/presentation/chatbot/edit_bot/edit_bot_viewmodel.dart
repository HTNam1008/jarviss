import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jarvis/domain/model/model.dart';
import 'package:jarvis/domain/usecase/get_assistant_usecase.dart';
import 'package:jarvis/domain/usecase/update_assistant_usecase.dart';
import 'package:jarvis/presentation/base/baseviewmodel.dart';

class EditBotViewModel extends BaseViewModel 
    implements EditBotViewModelInputs, EditBotViewModelOutputs {
  
  final UpdateAssistantUseCase _updateAssistantUseCase;
  final GetAssistantUseCase _getAssistantUseCase;
  
  final StreamController<bool> _isLoadingController = StreamController<bool>();
  final StreamController<String> _errorController = StreamController<String>();
  final StreamController<bool> _isAllInputValidController = StreamController<bool>();
  
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController instructionsController = TextEditingController();

  EditBotViewModel(this._updateAssistantUseCase, this._getAssistantUseCase);

  late AssistantCustom _assistant;
  AssistantCustom? get assistant => _assistant;

  Future<void> init(String assistantId) async {
    inputIsLoading.add(true);
    
    final result = await _getAssistantUseCase.execute(GetAssistantUseCaseInput(assistantId: assistantId));
    
    result.fold(
      (failure) => inputError.add(failure.message),
      (assistant) {
        _assistant = assistant;
        nameController.text = assistant.assistantName;
        descriptionController.text = assistant.description ?? '';
        instructionsController.text = assistant.instructions ?? '';
        _validateInputs();
      },
    );
    
    inputIsLoading.add(false);
  }

  @override
  void start() {
    _validateInputs();
    nameController.addListener(_validateInputs);
    descriptionController.addListener(_validateInputs);
    instructionsController.addListener(_validateInputs);
  }

  @override
  void dispose() {
    _isLoadingController.close();
    _errorController.close();
    _isAllInputValidController.close();
    nameController.dispose();
    descriptionController.dispose();
    instructionsController.dispose();
    super.dispose();
  }

  void _validateInputs() {
    inputIsAllInputValid.add(
      nameController.text.isNotEmpty &&
      descriptionController.text.isNotEmpty &&
      instructionsController.text.isNotEmpty
    );
  }

  @override
  Future<bool> updateBot() async {
    inputIsLoading.add(true);
    
    final result = await _updateAssistantUseCase.execute(
      UpdateAssistantUseCaseInput(
        assistantId: _assistant.id,
        assistantName: nameController.text,
        description: descriptionController.text,
        instructions: instructionsController.text,
      ),
    );
    
    inputIsLoading.add(false);
    
    return result.fold(
      (failure) {
        inputError.add(failure.message);
        return false;
      },
      (response) {
        _assistant = response;
        return true;
      },
    );
  }

  @override
  Sink<bool> get inputIsLoading => _isLoadingController.sink;
  @override
  Sink<String> get inputError => _errorController.sink;
  @override
  Sink<bool> get inputIsAllInputValid => _isAllInputValidController.sink;

  @override
  Stream<bool> get outputIsLoading => _isLoadingController.stream;
  @override
  Stream<String> get outputError => _errorController.stream;
  @override
  Stream<bool> get outputIsAllInputValid => _isAllInputValidController.stream;
  
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

abstract class EditBotViewModelInputs {
  Future<bool> updateBot();
  Sink<bool> get inputIsLoading;
  Sink<String> get inputError;
  Sink<bool> get inputIsAllInputValid;
}

abstract class EditBotViewModelOutputs {
  Stream<bool> get outputIsLoading;
  Stream<String> get outputError;
  Stream<bool> get outputIsAllInputValid;
}