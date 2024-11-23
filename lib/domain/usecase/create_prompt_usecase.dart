import 'package:dartz/dartz.dart';
import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/data/request/authentication/request.dart';
import 'package:jarvis/domain/model/prompt.dart';
import 'package:jarvis/domain/repository/prompt_repository.dart';

import 'base_usecase.dart';

class CreatePromptUseCase implements BaseUseCase<CreatePromptRequest, Prompt> {
  final PromptRepository _repository;

  CreatePromptUseCase(this._repository);

  @override
  Future<Either<Failure, Prompt>> execute(CreatePromptRequest input) async {
    return await _repository.createPrompt(input);
  }
}