import 'package:dartz/dartz.dart';
import 'package:jarvis/domain/repository/repository.dart';

import '../../data/network/failure.dart';
import '../repository/prompt_repository.dart';
import 'base_usecase.dart';

class DeleteKnowledgeUsecase implements BaseUseCase<String, void> {
  final Repository _repository;

  DeleteKnowledgeUsecase(this._repository);

  @override
  Future<Either<Failure, void>> execute(String knowledgeId) async {
    return await _repository.deleteKnowledge(knowledgeId);
  }
}