import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../../data/request/request.dart';
import '../model/prompt.dart';
import '../repository/prompt_repository.dart';
import 'base_usecase.dart';

class CreatePromptUseCase implements BaseUseCase<CreatePromptRequest, Prompt> {
  final PromptRepository _repository;

  CreatePromptUseCase(this._repository);

  @override
  Future<Either<Failure, Prompt>> execute(CreatePromptRequest input) async {
    return await _repository.createPrompt(input);
  }
}