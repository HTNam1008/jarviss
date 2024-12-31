import 'package:dartz/dartz.dart';
import 'package:jarvis/data/network/failure.dart';
import 'package:jarvis/data/request/ai_bot/update_assistant_new_thread_playground_request.dart';
import 'package:jarvis/domain/model/model.dart';
import 'package:jarvis/domain/repository/repository.dart';
import 'package:jarvis/domain/usecase/base_usecase.dart';

class UpdateAssistantNewThreadPlayGroundUseCase implements BaseUseCase<UpdateAssistantNewThreadPlayGroundInput, AssistantCustom> {
  final Repository _repository;

  UpdateAssistantNewThreadPlayGroundUseCase(this._repository);

  @override
  Future<Either<Failure, AssistantCustom>> execute(UpdateAssistantNewThreadPlayGroundInput input) async {
    return await _repository.updateAssistantNewThreadPlayGround(
      UpdateAssistantNewThreadPlayGroundRequest(
        assistantId: input.assistantId,
      ),
    );
  }
}

class UpdateAssistantNewThreadPlayGroundInput {
  String assistantId;

  UpdateAssistantNewThreadPlayGroundInput({
    required this.assistantId,
  });
}