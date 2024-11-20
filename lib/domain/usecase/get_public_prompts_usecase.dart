import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../model/prompt.dart';
import 'base_usecase.dart';
import '../../domain/repository/prompt_repository.dart';


class GetPublicPromptsUseCase implements BaseUseCase<String, List<Prompt>> {
  final PromptRepository _repository;

  GetPublicPromptsUseCase(this._repository);

  @override
  Future<Either<Failure, List<Prompt>>> execute(String category) async {
    return await _repository.getPublicPrompts(category);
  }
}