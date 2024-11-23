import 'package:dartz/dartz.dart';
import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/data/request/authentication/request.dart';
import 'package:jarvis/domain/repository/prompt_repository.dart';

import 'base_usecase.dart';

class UpdatePromptUseCase implements BaseUseCase<UpdatePromptUseCaseInput, void> {
  final PromptRepository _repository;

  UpdatePromptUseCase(this._repository);

  @override
  Future<Either<Failure, void>> execute(UpdatePromptUseCaseInput input) async {
    return await _repository.updatePrompt(
        input.promptId,
        UpdatePromptRequest(
            title: input.title,
            content: input.content,
            description: input.description,
            category: input.category,
            isPublic: input.isPublic,
            language: input.language,
        )
    );
  }
}

class UpdatePromptUseCaseInput {
  final String promptId;
  final String? title;
  final String? content;
  final String description;
  final String category;
  final String language;
  final bool isPublic;

  UpdatePromptUseCaseInput(
      this.promptId,
      this.title,
      this.content,
      this.description,
      this.category,
      this.language,
      this.isPublic
      );
}