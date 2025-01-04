// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/data/request/ai_bot/get_knowledge_relation_request.dart';
import 'package:jarvis/data/responses/ai_bot/get_knowledge_relation_response.dart';
import 'package:jarvis/domain/repository/repository.dart';
import 'package:jarvis/domain/usecase/base_usecase.dart';

class GetKnowledgeRelationUsecase implements BaseUseCase<GetKnowledgeRelationUsecaseInput, GetKnowledgeRelationResponse> {
  final Repository _repository;

  GetKnowledgeRelationUsecase(this._repository);

  @override
  Future<Either<Failure, GetKnowledgeRelationResponse>> execute(GetKnowledgeRelationUsecaseInput input) async {
    return await _repository.getKnowledgeRelation(
      GetKnowledgeRelationRequest(
        assistandId: input.assistandId,
        limit: input.limit,
        offset: input.offset,
      )
    );
  }
}

class GetKnowledgeRelationUsecaseInput {
    final String assistandId;
    final double? limit;
    final double? offset;

  GetKnowledgeRelationUsecaseInput({
    required this.assistandId,
    this.limit,
    this.offset,
  });
}
