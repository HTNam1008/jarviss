import 'package:dartz/dartz.dart';
import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/data/request/authentication/request.dart';
import 'package:jarvis/data/request/authentication_kb/knowledge_auth_request.dart';
import 'package:jarvis/data/responses/authentication_kb/knowledge_auth_response.dart';
import 'package:jarvis/domain/model/prompt.dart';
import 'package:jarvis/domain/repository/repository.dart';

import 'base_usecase.dart';

class CreateKnowledgeUsecase implements BaseUseCase<CreateKnowledgeRequest, KnowledgeResponse> {
  final Repository _repository;

  CreateKnowledgeUsecase(this._repository);

  @override
  Future<Either<Failure, KnowledgeResponse>> execute(CreateKnowledgeRequest input) async {
    return await _repository.createKnowledge(input);
  }
}