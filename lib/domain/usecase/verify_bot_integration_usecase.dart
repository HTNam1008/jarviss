/* import 'package:dartz/dartz.dart';
import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/data/request/ai_bot/create_assistant_request.dart';
import 'package:jarvis/domain/model/model.dart';
import 'package:jarvis/domain/repository/repository.dart';
import 'package:jarvis/domain/usecase/base_usecase.dart';

class VerifyBotIntegrationUsecase implements BaseUseCase<VerifyBotIntegrationUsecaseInput, AssistantCustom> {
  final Repository _repository;

  VerifyBotIntegrationUsecase(this._repository);

  @override
  Future<Either<Failure, >> execute(CreateAssistantUseCaseInput input) async {
    return await _repository.createAssistant(
      CreateAssistantRequest(
        assistantName: input.assistantName,
        description: input.description,
        instructions: input.instructions,
      ),
    );
  }
}

class VerifyBotIntegrationUsecaseInput {
  String assistantName;
  String description;
  String instructions;

  CreateAssistantUseCaseInput({
    required this.assistantName,
    required this.description,
    required this.instructions,
  });
} */