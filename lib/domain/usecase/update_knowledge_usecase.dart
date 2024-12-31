import 'package:dartz/dartz.dart';
import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/data/request/authentication/request.dart';
import 'package:jarvis/data/request/authentication_kb/knowledge_auth_request.dart';
import 'package:jarvis/data/responses/authentication_kb/knowledge_auth_response.dart';
import 'package:jarvis/domain/model/prompt.dart';
import 'package:jarvis/domain/repository/repository.dart';

import 'base_usecase.dart';

class UpdateKnowledgeUseCase implements BaseUseCase<UpdateKnowledgeParams, KnowledgeResponse> {
  final Repository _repository;

  UpdateKnowledgeUseCase(this._repository);

  @override
  Future<Either<Failure, KnowledgeResponse>> execute(UpdateKnowledgeParams params) async {
    return await _repository.updateKnowledge(params.id, params.request);
  }
}

class UpdateKnowledgeParams {
  final String id;
  final CreateKnowledgeRequest request;

  UpdateKnowledgeParams({
    required this.id,
    required this.request,
  });
}