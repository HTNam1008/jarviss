import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:jarvis/app/constant.dart';
import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/data/request/ai_bot/get_assistants_request.dart';
import 'package:jarvis/data/responses/ai_bot/get_assistants_response.dart';
import 'package:jarvis/domain/repository/repository.dart';
import 'package:jarvis/domain/usecase/base_usecase.dart';

import '../../data/responses/knowledge/get_knowledge_response.dart';

class GetKnowledgeUsecase implements BaseUseCase<GetKnowledgeUseCaseInput, GetKnowledgeResponse> {
  final Repository _repository;

  GetKnowledgeUsecase(this._repository);

  @override
  Future<Either<Failure, GetKnowledgeResponse>> execute(GetKnowledgeUseCaseInput input) async {
    log('Fetched knowledge usecase');

    return await _repository.getKnowledge(
        limit: input.limit,
        offset: input.offset,
        order: input.order,
        orderField: input.orderField,
        q: input.q,
    );
  }
}

class GetKnowledgeUseCaseInput {
  final int? limit;
  final int? offset;
  final EnumOrder? order;
  final String? orderField;
  final String? q;

  GetKnowledgeUseCaseInput({
    this.limit,
    this.offset,
    this.order,
    this.orderField,
    this.q,
  });
}