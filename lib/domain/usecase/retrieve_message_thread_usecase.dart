import 'package:dartz/dartz.dart';
import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/data/request/ai_bot/retrieve_message_thread_request.dart';
import 'package:jarvis/domain/model/model.dart';
import 'package:jarvis/domain/repository/repository.dart';
import 'package:jarvis/domain/usecase/base_usecase.dart';

class RetrieveMessageThreadUseCase implements BaseUseCase<RetrieveMessageThreadUseCaseInput, MessageAssistants> {
  final Repository _repository;

  RetrieveMessageThreadUseCase(this._repository);

  @override
  Future<Either<Failure, MessageAssistants>> execute(RetrieveMessageThreadUseCaseInput input) async {
    return await _repository.retrieveMessageThread(
      RetrieveMessageThreadRequest(
        openAiThreadId: input.openAiThreadId,
      ),
    );
  }
}

class RetrieveMessageThreadUseCaseInput {
  final String openAiThreadId;

  RetrieveMessageThreadUseCaseInput({required this.openAiThreadId});
}