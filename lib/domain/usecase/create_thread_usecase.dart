import 'package:dartz/dartz.dart';
import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/data/request/ai_bot/create_thread_request.dart';
import 'package:jarvis/domain/model/model.dart';
import 'package:jarvis/domain/repository/repository.dart';
import 'package:jarvis/domain/usecase/base_usecase.dart';

class CreateThreadUseCase implements BaseUseCase<CreateThreadUseCaseInput, Thread> {
  final Repository _repository;

  CreateThreadUseCase(this._repository);

  @override
  Future<Either<Failure, Thread>> execute(CreateThreadUseCaseInput input) async {
    return await _repository.createThread(
      CreateThreadRequest(
        assistantId: input.assistantId,
        firstMessage: input.firstMessage,
      ),
    );
  }
}

class CreateThreadUseCaseInput {
  String assistantId;
  String? firstMessage;

  CreateThreadUseCaseInput({
    required this.assistantId,
    this.firstMessage,
  });
}