// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/data/request/ai_bot/remove_knowledge_request.dart';
import 'package:jarvis/domain/repository/repository.dart';
import 'package:jarvis/domain/usecase/base_usecase.dart';

class RemoveKnowledgeUsecase implements BaseUseCase<RemoveKnowledgeUsecaseInput, void> {
  final Repository _repository;

  RemoveKnowledgeUsecase(this._repository);

  @override
  Future<Either<Failure, void>> execute(RemoveKnowledgeUsecaseInput input) async {
    return await _repository.removeKnowledgeAssistant(
      RemoveKnowledgeRequest(
        assistandId: input.assistandId,
        knowledgeId: input.knowledgeId,
      )
    );
  }
}

class RemoveKnowledgeUsecaseInput {
    final String assistandId;
    final String knowledgeId;

  RemoveKnowledgeUsecaseInput({
    required this.assistandId,
    required this.knowledgeId,
  });
}
