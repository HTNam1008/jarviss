import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../repository/prompt_repository.dart';
import 'base_usecase.dart';

class DeletePromptUseCase implements BaseUseCase<String, void> {
  final PromptRepository _repository;

  DeletePromptUseCase(this._repository);

  @override
  Future<Either<Failure, void>> execute(String promptId) async {
    return await _repository.deletePrompt(promptId);
  }
}