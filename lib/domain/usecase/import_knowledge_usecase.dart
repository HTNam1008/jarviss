// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/data/request/ai_bot/import_knowledge_request.dart';
import 'package:jarvis/domain/repository/repository.dart';
import 'package:jarvis/domain/usecase/base_usecase.dart';

class ImportKnowledgeUsecase implements BaseUseCase<ImportKnowledgeUsecaseInput, void> {
  final Repository _repository;

  ImportKnowledgeUsecase(this._repository);

  @override
  Future<Either<Failure, void>> execute(ImportKnowledgeUsecaseInput input) async {
    return await _repository.importKnowledgeAssistant(
      ImportKnowledgeRequest(
        assistandId: input.assistandId,
        knowledgeId: input.knowledgeId,
      )
    );
  }
}

class ImportKnowledgeUsecaseInput {
    final String assistandId;
    final String knowledgeId;

  ImportKnowledgeUsecaseInput({
    required this.assistandId,
    required this.knowledgeId,
  });
}
