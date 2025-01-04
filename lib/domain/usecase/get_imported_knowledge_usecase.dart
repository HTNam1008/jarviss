// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:jarvis/app/constant.dart';
import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/data/request/ai_bot/get_imported_knowledge_request.dart';
import 'package:jarvis/data/responses/ai_bot/get_imported_knowledge_response.dart';
import 'package:jarvis/domain/repository/repository.dart';
import 'package:jarvis/domain/usecase/base_usecase.dart';

class GetImportedKnowledgeUsecase implements BaseUseCase<GetImportedKnowledgeUsecaseInput, GetImportedKnowledgeResponse> {
  final Repository _repository;

  GetImportedKnowledgeUsecase(this._repository);

  @override
  Future<Either<Failure, GetImportedKnowledgeResponse>> execute(GetImportedKnowledgeUsecaseInput input) async {
    return await _repository.getImportedKnowledgeAssistant(
      GetImportedKnowledgeRequest(
        assistandId: input.assistandId,
        limit: input.limit,
        offset: input.offset,
        order: input.order,
        orderField: input.orderField,
        q: input.q,
      )
    );
  }
}

class GetImportedKnowledgeUsecaseInput {
    final String assistandId;
    final double? limit;
    final double? offset;
    final EnumOrder? order;
    final String? orderField;
    final String? q;

  GetImportedKnowledgeUsecaseInput({
    required this.assistandId,
    this.limit,
    this.offset,
    this.order,
    this.orderField,
    this.q,
  });
}
