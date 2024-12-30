import 'package:dartz/dartz.dart';
import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/data/request/ai_bot/get_assistant_request.dart';
import 'package:jarvis/domain/model/model.dart';
import 'package:jarvis/domain/repository/repository.dart';
import 'package:jarvis/domain/usecase/base_usecase.dart';

class GetAssistantUseCase implements BaseUseCase<GetAssistantUseCaseInput, AssistantCustom> {
  final Repository _repository;

  GetAssistantUseCase(this._repository);

  @override
  Future<Either<Failure, AssistantCustom>> execute(GetAssistantUseCaseInput input) async {
    return await _repository.getAssistant(
      GetAssistantRequest(
        assistantId: input.assistantId,
      ),
    );
  }
}

class GetAssistantUseCaseInput {
  final String assistantId;

  GetAssistantUseCaseInput({required this.assistantId});
}