import 'package:dartz/dartz.dart';
import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/data/request/ai_bot/delete_assistant_request.dart';
import 'package:jarvis/domain/repository/repository.dart';
import 'package:jarvis/domain/usecase/base_usecase.dart';

class DeleteAssistantUseCase implements BaseUseCase<DeleteAssistantRequest, void> {
  final Repository _repository;

  DeleteAssistantUseCase(this._repository);

  @override
  Future<Either<Failure, void>> execute(DeleteAssistantRequest deleteAssistantRequest) async {
    return await _repository.deleteAssistant(deleteAssistantRequest);
  }
}