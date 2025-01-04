import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jarvis/app/constant.dart';
import 'package:jarvis/data/responses/ai_bot/get_assistants_response.dart';
import 'package:jarvis/domain/model/model.dart';
import 'package:jarvis/domain/usecase/create_assistant_usecase.dart';
import 'package:jarvis/domain/usecase/get_knowledge_usecase.dart';
import 'package:jarvis/domain/usecase/import_knowledge_usecase.dart';
import 'package:jarvis/presentation/base/baseviewmodel.dart';

class CreateBotViewModel extends BaseViewModel 
    implements CreateBotViewModelInputs, CreateBotViewModelOutputs {
  
  final CreateAssistantUseCase _createAssistantUseCase;
  final GetKnowledgeUsecase _getKnowledgeUsecase;
  final ImportKnowledgeUsecase _importKnowledgeUsecase;

  final StreamController<bool> _isLoadingController = StreamController<bool>.broadcast();
  final StreamController<String> _errorController = StreamController<String>();
  final StreamController<bool> _isAllInputValidController = StreamController<bool>();
  final StreamController<List<KnowledgeData>> _knowledgeController = StreamController<List<KnowledgeData>>.broadcast();
  // final StreamController<Set<String>> _importedKnowledgeController = 
  //     StreamController<Set<String>>.broadcast();

  final StreamController<Set<String>> _selectedIdsController = 
      StreamController<Set<String>>.broadcast();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController instructionsController = TextEditingController();

  AssistantCustom? _createdAssistant;
  AssistantCustom? get createdAssistant => _createdAssistant;

  final Set<String> _importedKnowledgeIds = {};
  final Set<String> _selectedKnowledgeIds = {};

  CreateBotViewModel(this._createAssistantUseCase, this._getKnowledgeUsecase, this._importKnowledgeUsecase);

  bool isKnowledgeSelected(String knowledgeId) => 
      _selectedKnowledgeIds.contains(knowledgeId);

  int get selectedKnowledgeCount => _selectedKnowledgeIds.length;
  
  @override
  void start() {
    _validateInputs();
    _loadKnowledge();
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
    _knowledgeController.close();
    _selectedIdsController.close();
    // _importedKnowledgeController.close();
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
  Future<bool> createBot() async {
    inputIsLoading.add(true);
    
    final result = await _createAssistantUseCase.execute(
      CreateAssistantUseCaseInput(
        assistantName: nameController.text,
        description: descriptionController.text,
        instructions: instructionsController.text,
      ),
    );
        
    return result.fold(
      (failure) {
        inputError.add(failure.message);
        return false;
      },
      (response) async {
        _createdAssistant = response;

        for (final knowledgeId in _selectedKnowledgeIds) {
          final importResult = await _importKnowledgeUsecase.execute(
            ImportKnowledgeUsecaseInput(
              assistandId: response.id,
              knowledgeId: knowledgeId,
            ),
          );

          if (importResult.isLeft()) {
            inputError.add('Failed to import knowledge: $knowledgeId');
            return false;
          }
        }
        inputIsLoading.add(false);
        return true;
      },
    );
  }

  Future<void> _loadKnowledge() async{
    inputIsLoading.add(true);
    
    final result = await _getKnowledgeUsecase.execute(
      GetKnowledgeUseCaseInput(
        limit: 50,
        order: EnumOrder.DESC,
        orderField: "createdAt",
      )
    );
    
    result.fold(
      (failure) => inputError.add(failure.message),
      (response) {
        inputKnowledge.add(response.data);
      },
    );

    inputIsLoading.add(false);
  }

  void toggleKnowledge(String knowledgeId) {
    if (_selectedKnowledgeIds.contains(knowledgeId)) {
      _selectedKnowledgeIds.remove(knowledgeId);
    } else {
      _selectedKnowledgeIds.add(knowledgeId);
    }
    _selectedIdsController.add(_selectedKnowledgeIds);
  }

  Future<bool> _importKnowledge(String knowledgeId) async {
    inputIsLoading.add(true);
    
    final result = await _importKnowledgeUsecase.execute(
      ImportKnowledgeUsecaseInput(
        assistandId: _createdAssistant!.id,
        knowledgeId: knowledgeId,
      ),
    );

    inputIsLoading.add(false);
    
    return result.fold(
      (failure) {
        inputError.add(failure.message);
        return false;
      },
      (_) {
        _importedKnowledgeIds.add(knowledgeId);
        // inputImportedKnowledge.add(_importedKnowledgeIds);
        return true;
      },
    );
  }

  Sink<Set<String>> get inputSelectedIds => _selectedIdsController.sink;
  Stream<Set<String>> get outputSelectedIds => _selectedIdsController.stream;

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
    throw UnimplementedError();
  }
  
  @override
  Future<void> navigateReplaceNamed(BuildContext context, String route) {
    throw UnimplementedError();
  }
  
  Sink<List<KnowledgeData>> get inputKnowledge => _knowledgeController.sink;
  Stream<List<KnowledgeData>> get outputKnowledge => _knowledgeController.stream;

  // Sink<Set<String>> get inputImportedKnowledge => _importedKnowledgeController.sink;
  // Stream<Set<String>> get outputImportedKnowledge => _importedKnowledgeController.stream;
}

abstract class CreateBotViewModelInputs {
  Future<bool> createBot();
  Sink<bool> get inputIsLoading;
  Sink<String> get inputError;
  Sink<bool> get inputIsAllInputValid;
}

abstract class CreateBotViewModelOutputs {
  Stream<bool> get outputIsLoading;
  Stream<String> get outputError;
  Stream<bool> get outputIsAllInputValid;
}