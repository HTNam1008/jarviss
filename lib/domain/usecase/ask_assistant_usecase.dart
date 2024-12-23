// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/data/request/ai_bot/ask_assistant_request.dart';
import 'package:jarvis/data/request/ai_bot/create_assistant_request.dart';
import 'package:jarvis/domain/model/model.dart';
import 'package:jarvis/domain/repository/repository.dart';
import 'package:jarvis/domain/usecase/base_usecase.dart';

class AskAssistantUseCase implements BaseUseCase<CreateAssistantUseCaseInput, String> {
  final Repository _repository;

  AskAssistantUseCase(this._repository);

  @override
  Future<Either<Failure, String>> execute(CreateAssistantUseCaseInput input) async {
    return await _repository.askAssistant(
      AskAssistantRequest(
        assistandId: input.assistandId,
        message: input.message,
        openAiThreadId: input.openAiThreadId,
        additionalInstruction: input.additionalInstruction,
      ),
    );
  }
}

class CreateAssistantUseCaseInput {
  String assistandId;
  String message;
  String openAiThreadId;
  String additionalInstruction;

  CreateAssistantUseCaseInput({
    required this.assistandId,
    required this.message,
    required this.openAiThreadId,
    required this.additionalInstruction,
  });


}
