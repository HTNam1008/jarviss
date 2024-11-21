import 'package:dartz/dartz.dart';

import '../../data/network/failure.dart';
import '../model/prompt.dart';
import 'base_usecase.dart';
import '../../domain/repository/prompt_repository.dart';


class GetPublicPromptsUseCase implements BaseUseCase<GetPublicPromptsUseCaseInput, List<Prompt>> {
  final PromptRepository _repository;

  GetPublicPromptsUseCase(this._repository);

  @override
  Future<Either<Failure, List<Prompt>>> execute(GetPublicPromptsUseCaseInput input) async {
    return await _repository.getPublicPrompts(input.category, isFavorite: input.isFavorite);
  }
}

class GetPublicPromptsUseCaseInput {
  final String category;
  final bool? isFavorite;

  GetPublicPromptsUseCaseInput(this.category, {this.isFavorite});
}
class AddPromptToFavoriteUseCase implements BaseUseCase<String, void> {
  final PromptRepository _repository;

  AddPromptToFavoriteUseCase(this._repository);

  @override
  Future<Either<Failure, void>> execute(String promptId) async {
    return await _repository.addToFavorites(promptId);
  }
}