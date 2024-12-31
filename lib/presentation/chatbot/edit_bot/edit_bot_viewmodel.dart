import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jarvis/data/responses/ai_bot/get_knowledge_relation_response.dart';
import 'package:jarvis/domain/model/model.dart';
import 'package:jarvis/domain/usecase/get_assistant_usecase.dart';
import 'package:jarvis/domain/usecase/get_knowledge_relation_usecase.dart';
import 'package:jarvis/domain/usecase/import_knowledge_usecase.dart';
import 'package:jarvis/domain/usecase/remove_knowledge_usecase.dart';
import 'package:jarvis/domain/usecase/update_assistant_usecase.dart';
import 'package:jarvis/presentation/base/baseviewmodel.dart';

class EditBotViewModel extends BaseViewModel 
    implements EditBotViewModelInputs, EditBotViewModelOutputs {
  
  final UpdateAssistantUseCase _updateAssistantUseCase;
  final GetAssistantUseCase _getAssistantUseCase;
  final GetKnowledgeRelationUsecase _getKnowledgeRelationUsecase;
  final ImportKnowledgeUsecase _importKnowledgeUsecase;
  final RemoveKnowledgeUsecase _removeKnowledgeUsecase;
  
  final StreamController<bool> _isLoadingController = StreamController<bool>();
  final StreamController<String> _errorController = StreamController<String>();
  final StreamController<bool> _isAllInputValidController = StreamController<bool>();
  final StreamController<List<KnowledgeRelation>> _knowledgeController = 
      StreamController<List<KnowledgeRelation>>.broadcast();
      
  final Set<String> _importedKnowledgeIds = {};

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController instructionsController = TextEditingController();

  EditBotViewModel(this._updateAssistantUseCase, this._getAssistantUseCase, this._getKnowledgeRelationUsecase, this._importKnowledgeUsecase, this._removeKnowledgeUsecase);

  late AssistantCustom _assistant;
  AssistantCustom? get assistant => _assistant;

  Future<void> init(String assistantId) async {
    inputIsLoading.add(true);
    
    /* final result = await _getAssistantUseCase.execute(GetAssistantUseCaseInput(assistantId: assistantId));
    
    result.fold(
      (failure) => inputError.add(failure.message),
      (assistant) {
        _assistant = assistant;
        nameController.text = assistant.assistantName;
        descriptionController.text = assistant.description ?? '';
        instructionsController.text = assistant.instructions ?? '';
        _validateInputs();
      },
    ); */

    await Future.wait([
      _loadAssistant(assistantId),
      _loadKnowledgeRelation(assistantId),
    ]);
    
    inputIsLoading.add(false);
  }

  Future<void> _loadAssistant(String assistantId) async {
    final result = await _getAssistantUseCase.execute(
      GetAssistantUseCaseInput(assistantId: assistantId),
    );

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
  }

  Future<void> _loadKnowledgeRelation(String assistantId) async {
    final result = await _getKnowledgeRelationUsecase.execute(
      GetKnowledgeRelationUsecaseInput(
        assistandId: assistantId,
        limit: 50,
        offset: 0,
      ),
    );

    result.fold(
      (failure) => inputError.add(failure.message),
      (response) {
        inputKnowledge.add(response.data);
        _importedKnowledgeIds.addAll(
          response.data.where((k) => k.isImported).map((k) => k.id)
        );
      },
    );
  }

  Future<bool> toggleKnowledge(String knowledgeId) async {
    if (_importedKnowledgeIds.contains(knowledgeId)) {
      return await _removeKnowledge(knowledgeId);
    } else {
      return await _importKnowledge(knowledgeId);
    }
  }

  Future<bool> _importKnowledge(String knowledgeId) async {
    inputIsLoading.add(true);
    
    final result = await _importKnowledgeUsecase.execute(
      ImportKnowledgeUsecaseInput(
        assistandId: _assistant.id,
        knowledgeId: knowledgeId,
      ),
    );

    inputIsLoading.add(false);
    
    if (result.isRight()) {
      _importedKnowledgeIds.add(knowledgeId);
      await _loadKnowledgeRelation(_assistant.id);
      return true;
    }
    
    result.fold(
      (failure) => inputError.add(failure.message),
      (_) {},
    );
    return false;
  }

  Future<bool> _removeKnowledge(String knowledgeId) async {
    inputIsLoading.add(true);
    
    final result = await _removeKnowledgeUsecase.execute(
      RemoveKnowledgeUsecaseInput(
        assistandId: _assistant.id,
        knowledgeId: knowledgeId,
      ),
    );

    inputIsLoading.add(false);
    
    if (result.isRight()) {
      _importedKnowledgeIds.remove(knowledgeId);
      await _loadKnowledgeRelation(_assistant.id);
      return true;
    }
    
    result.fold(
      (failure) => inputError.add(failure.message),
      (_) {},
    );
    return false;
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

  Sink<List<KnowledgeRelation>> get inputKnowledge => _knowledgeController.sink;
  Stream<List<KnowledgeRelation>> get outputKnowledge => _knowledgeController.stream;

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