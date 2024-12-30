import 'package:dartz/dartz.dart';
import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/data/request/ai_bot/update_assistant_request.dart';
import 'package:jarvis/domain/model/model.dart';
import 'package:jarvis/domain/repository/repository.dart';
import 'package:jarvis/domain/usecase/base_usecase.dart';

class UpdateAssistantUseCase implements BaseUseCase<UpdateAssistantUseCaseInput, AssistantCustom> {
  final Repository _repository;

  UpdateAssistantUseCase(this._repository);

  @override
  Future<Either<Failure, AssistantCustom>> execute(UpdateAssistantUseCaseInput input) async {
    return await _repository.updateAssistant(
      UpdateAssistantRequest(
        assistantId: input.assistantId,
        assistantName: input.assistantName,
        description: input.description,
        instructions: input.instructions,
      ),
    );
  }
}

class UpdateAssistantUseCaseInput {
  String assistantId;
  String assistantName;
  String? description;
  String? instructions;

  UpdateAssistantUseCaseInput({
    required this.assistantId,
    required this.assistantName,
    this.description,
    this.instructions,
  });
}